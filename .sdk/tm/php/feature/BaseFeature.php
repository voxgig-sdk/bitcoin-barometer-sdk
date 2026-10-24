<?php
declare(strict_types=1);

// BitcoinBarometer SDK base feature

class BitcoinBarometerBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(BitcoinBarometerContext $ctx, array $options): void {}
    public function PostConstruct(BitcoinBarometerContext $ctx): void {}
    public function PostConstructEntity(BitcoinBarometerContext $ctx): void {}
    public function SetData(BitcoinBarometerContext $ctx): void {}
    public function GetData(BitcoinBarometerContext $ctx): void {}
    public function GetMatch(BitcoinBarometerContext $ctx): void {}
    public function SetMatch(BitcoinBarometerContext $ctx): void {}
    public function PrePoint(BitcoinBarometerContext $ctx): void {}
    public function PreSpec(BitcoinBarometerContext $ctx): void {}
    public function PreRequest(BitcoinBarometerContext $ctx): void {}
    public function PreResponse(BitcoinBarometerContext $ctx): void {}
    public function PreResult(BitcoinBarometerContext $ctx): void {}
    public function PreDone(BitcoinBarometerContext $ctx): void {}
    public function PreUnexpected(BitcoinBarometerContext $ctx): void {}
}
