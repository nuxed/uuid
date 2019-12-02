namespace Nuxed\Test\Uuid;

use namespace Nuxed\Uuid;
use namespace Facebook\HackTest;
use namespace HH\Lib\Regex;

use function Facebook\FBExpect\expect;

class UuidTest extends HackTest\HackTest {

  <<HackTest\DataProvider('getTypes')>>
  public function testGenerate(Uuid\Type $type): void {
    $uuid = Uuid\generate($type);

    expect(Regex\matches(
      $uuid,
      re"/[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}/",
    ))
      ->toBeTrue();
  }

  public function testTime(): void {
    expect(Uuid\time('b691c99c-7fc5-11d8-9fa8-00065b896488'))->toBeSame(
      1080374815,
    );
    expect(Uuid\time('878b258c-a9f1-467c-8e1d-47d79ca2c01b'))->toBeNull();
  }

  public function testEncode(): void {
    expect(Uuid\encode('61616161-6161-6161-6161-616161616161'))->toBeSame(
      'aaaaaaaaaaaaaaaa',
    );
  }

  public function testDecode(): void {
    expect(Uuid\decode('aaaaaaaaaaaaaaaa'))->toBeSame(
      '61616161-6161-6161-6161-616161616161',
    );
  }

  public function testIsNull(): void {
    expect(Uuid\is_null(Uuid\generate(Uuid\Type::Null)))
      ->toBeTrue();

    expect(Uuid\is_null(Uuid\generate(Uuid\Type::Random)))
      ->toBeFalse();

    expect(Uuid\is_null(Uuid\generate(Uuid\Type::Time)))
      ->toBeFalse();
  }

  <<HackTest\DataProvider('getValidationData')>>
  public function testIsValid(string $uuid, bool $valid): void {
    expect(Uuid\is_valid($uuid))
      ->toBeSame($valid);
  }

  public function getValidationData(): Container<(string, bool)> {
    $data = vec[];
    foreach ($this->getTypes() as list($type)) {
      $data[] = tuple(Uuid\generate($type), true);
    }

    $data[] = tuple('g1616161-616x-6161-6161-6161616161y1', false);
    $data[] = tuple('', false);
    return $data;
  }

  public function getTypes(): Container<(Uuid\Type)> {
    return vec[
      tuple(Uuid\Type::Random),
      tuple(Uuid\Type::Time),
      tuple(Uuid\Type::Null),
    ];
  }
}
