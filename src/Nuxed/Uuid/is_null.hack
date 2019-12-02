namespace Nuxed\Uuid;

/**
 * Check wheter an UUID is the NULL UUID 00000000-0000-0000-0000-000000000000
 */
function is_null(string $uuid): bool {
  return $uuid === _Private\NULL_UUID;
}
