namespace Nuxed\Uuid;

use namespace HH\Lib\Str;

/**
 * Converts the UUID string given by in into the binary representation.
 */
function encode(string $uuid): string {
  if (!is_valid($uuid)) {
    throw new Exception\InvalidArgumentException(
      Str\format('Invalid uuid(%s)', $uuid),
    );
  }

  $uuid = Str\replace($uuid, '-', '');
  return \pack('H*', $uuid);
}
