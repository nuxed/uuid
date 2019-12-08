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

  if (Type::Time !== type($uuid)) {
    return null;
  }

  $fields = fields($uuid);
  $high = $fields['time_mid'] | (($fields['time_hi_version'] & 0xFFF) << 16);
  $clockReg = $fields['time_low'] | ($high << 32);
  $clockReg -= 122192928000000000;
  return (int)($clockReg / 10000000);
}
