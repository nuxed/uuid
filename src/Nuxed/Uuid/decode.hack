namespace Nuxed\Uuid;

use namespace HH\Lib\Str;

function decode(string $uuid): ?string {
  $data = \unpack('H*', $uuid);
  $data = $data[1];
  if (32 !== Str\length($data)) {
    return null;
  }

  $uuid = Str\format(
    '%s-%s-%s-%s-%s',
    Str\slice($data, 0, 8),
    Str\slice($data, 8, 4),
    Str\slice($data, 12, 4),
    Str\slice($data, 16, 4),
    Str\slice($data, 20, 12),
  );
  $details = _Private\parse($uuid);
  if ($details is null) {
    return null;
  }

  return $uuid;
}
