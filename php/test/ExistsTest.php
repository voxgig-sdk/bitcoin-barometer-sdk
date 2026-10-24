<?php
declare(strict_types=1);

// BitcoinBarometer SDK exists test

require_once __DIR__ . '/../bitcoinbarometer_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = BitcoinBarometerSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
