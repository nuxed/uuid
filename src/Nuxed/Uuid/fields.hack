namespace Nuxed\Uuid;

use namespace HH\Lib\Str;

function fields(
  string $uuid,
): shape(
  'time_low' => int,
  'time_mid' => int,
  'time_hi_version' => int,
  'clock_seq' => int,
  'node' => int,
) {
  $fields = _Private\parse($uuid);
  if ($fields is null) {
    throw new Exception\InvalidArgumentException(Str\format('Invalid uuid(%s)', $uuid));
  }

  return $fields;
}
