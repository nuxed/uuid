namespace Nuxed\Uuid\_Private;

use namespace HH\Lib\{Regex, Str};

function parse(
  string $uuid,
): ?shape(
  'time_low' => int,
  'time_mid' => int,
  'time_hi_version' => int,
  'clock_seq' => int,
  'node' => int,
) {
  if (36 !== Str\length($uuid)) {
    return null;
  }

  $pattern =
    re"{^(?<time_low>[0-9a-f]{8})-(?<time_mid>[0-9a-f]{4})-(?<time_hi_version>[0-9a-f]{4})-(?<clock_seq>[0-9a-f]{4})-(?<node>[0-9a-f]{12})$}i";

  if (!Regex\matches($uuid, $pattern)) {
    return null;
  }

  $match = Regex\first_match($uuid, $pattern) as nonnull;

  return shape(
    'time_low' => \hexdec($match['time_low']),
    'time_mid' => \hexdec($match['time_mid']),
    'time_hi_version' => \hexdec($match['time_hi_version']),
    'clock_seq' => \hexdec($match['clock_seq']),
    'node' => \hexdec($match['node']),
  );
}
