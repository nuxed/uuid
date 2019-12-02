<p align="center"><img src="https://avatars3.githubusercontent.com/u/45311177?s=200&v=4"></p>

<p align="center">
<a href="https://travis-ci.org/nuxed/uuid"><img src="https://travis-ci.org/nuxed/uuid.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/nuxed/uuid"><img src="https://poser.pugx.org/nuxed/uuid/d/total.svg" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/nuxed/uuid"><img src="https://poser.pugx.org/nuxed/uuid/v/stable.svg" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/nuxed/uuid"><img src="https://poser.pugx.org/nuxed/uuid/license.svg" alt="License"></a>
</p>

# Nuxed Uuid

The Nuxed Uuid component provides a simple functional API for generating UUIDs.

### Installation

This package can be installed with [Composer](https://getcomposer.org).

```console
$ composer require nuxed/uuid
```

### Example

```hack
use namespace Nuxed\Uuid;

<<__EntryPoint>>
async function main(): Awaitable<void> {
  $uuid = Uuid\generate(Uuid\Type::Time);
}
```

---

### Security

For information on reporting security vulnerabilities in Nuxed, see [SECURITY.md](SECURITY.md).

---

### License

Nuxed is open-sourced software licensed under the MIT-licensed.
