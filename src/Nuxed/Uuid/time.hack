namespace Nuxed\Uuid;

/**
 * Extract creation time from a time based UUID as UNIX timestamp
 */
function time(string $uuid): ?int {
  if (\PHP_INT_SIZE === 4) {
    throw new Exception\RuntimeException(
      'UUID time generation is not supported on 32-bit systems.',
    );
  }

  $details = _Private\parse($uuid);
  if (null === $details) {
    return null;
  }

  if (Type::Time !== type($uuid)) {
    return null;
  }

  $high = $details['time_mid'] |
    (($details['time_hi_and_version'] & 0xFFF) << 16);
  $clockReg = $details['time_low'] | ($high << 32);
  $clockReg -= 122192928000000000;
  return (int)($clockReg / 10000000);
}
