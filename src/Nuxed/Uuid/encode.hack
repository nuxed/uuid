namespace Nuxed\Uuid;

use namespace HH\Lib\Str;

function encode(string $uuid): ?string {
  $details = _Private\parse($uuid);
  if ($details is null) {
    return null;
  }

  $uuid = Str\replace($uuid, '-', '');
  return \pack('H*', $uuid);
}
