namespace Nuxed\Uuid;

enum Type: int as int {
  Null = 0;
  Time = 1;
  Random = 4;
}

/**
 * Retrieve the type of the given UUID.
 */
function type(string $uuid): ?Type {
  if (is_null($uuid)) {
    return Type::Null;
  }

  $details = _Private\parse($uuid);
  if (null === $details) {
    return null;
  }

  return Type::coerce(($details['time_hi_and_version'] >> 12) & 0xF);
}
