namespace Nuxed\Uuid;

use namespace Nuxed\Crypto\Hex;
use namespace HH\Lib\{SecureRandom, Str};

/**
 * Generate a new UUID
 */
function generate(Type $type = Type::Random): string {
  if (Type::Null === $type) {
    return _Private\NULL_UUID;
  }

  if (Type::Random === $type) {
    $uuid = Hex\encode(SecureRandom\string(32));

    return Str\format(
      '%08s-%04s-%04x-%04x-%012s',
      // 32 bits for "time_low"
      Str\slice($uuid, 0, 8),
      // 16 bits for "time_mid"
      Str\slice($uuid, 8, 4),
      // 16 bits for "time_hi_and_version",
      // four most significant bits holds version number 4
      \hexdec(Str\slice($uuid, 12, 3)) & 0x0fff | 0x4000,
      // 16 bits:
      // * 8 bits for "clk_seq_hi_res",
      // * 8 bits for "clk_seq_low",
      // two most significant bits holds zero and one for variant DCE1.1
      \hexdec(Str\slice($uuid, 16, 4)) & 0x3fff | 0x8000,
      // 48 bits for "node"
      Str\slice($uuid, 20, 12),
    );
  }

  if (4 === \PHP_INT_SIZE) {
    throw new Exception\RuntimeException(
      'UUID time generation is not supported on 32-bit systems.',
    );
  }

  // https://tools.ietf.org/html/rfc4122#section-4.1.4
  // 0x01b21dd213814000 is the number of 100-ns intervals between the
  // UUID epoch 1582-10-15 00:00:00 and the Unix epoch 1970-01-01 00:00:00.
  $offset = 0x01b21dd213814000;
  $timeOfDay = \gettimeofday();
  $time = ($timeOfDay['sec'] * 10000000) + ($timeOfDay['usec'] * 10) + $offset;
  // https://tools.ietf.org/html/rfc4122#section-4.1.5
  // We are using a random data for the sake of simplicity: since we are
  // not able to get a super precise timeOfDay as a unique sequence
  $clockSeq = SecureRandom\int(0, 0x3fff);
  $success = false;
  $node = \apc_fetch('__nuxed_uuid_node', inout $success);
  if (false === $success || false === $node) {
    $node = Str\format(
      '%06x%06x',
      SecureRandom\int(0, 0xffffff) | 0x010000,
      SecureRandom\int(0, 0xffffff),
    );
    \apc_store('__nuxed_uuid_node', $node);
  }

  return Str\format(
    '%08x-%04x-%04x-%04x-%012s',

    // 32 bits for "time_low"
    $time & 0xffffffff,

    // 16 bits for "time_mid"
    ($time >> 32) & 0xffff,

    // 16 bits for "time_hi_and_version",
    // four most significant bits holds version number 1
    ($time >> 48) | 1 << 12,

    // 16 bits:
    // * 8 bits for "clk_seq_hi_res",
    // * 8 bits for "clk_seq_low",
    // two most significant bits holds zero and one for variant DCE1.1
    $clockSeq | 0x8000,

    // 48 bits for "node"
    $node,
  );
}
