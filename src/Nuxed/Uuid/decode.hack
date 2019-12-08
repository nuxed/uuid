namespace Nuxed\Uuid;

use namespace HH\Lib\Str;

function decode(string $input): string {
  $data = \unpack('H*', $input);
  $data = $data[1];
  if (32 !== Str\length($data)) {
    throw new Exception\InvalidArgumentException(
      'Invalid binary representation for uuid.',
    );
  }

  $uuid = Str\format(
    '%s-%s-%s-%s-%s',
    Str\slice($data, 0, 8),
    Str\slice($data, 8, 4),
    Str\slice($data, 12, 4),
    Str\slice($data, 16, 4),
    Str\slice($data, 20, 12),
  );

  if (!is_valid($uuid)) {
    throw new Exception\RuntimeException(Str\format(
      'unable to construct a valid uuid from given input ( %s )',
      $input,
    ));
  }

  return $uuid;
}
