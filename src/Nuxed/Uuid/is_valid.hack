namespace Nuxed\Uuid;

/**
 * Check whether a given UUID string is a valid UUID
 */
function is_valid(string $uuid): bool {
  return _Private\parse($uuid) is nonnull;
}
