<?php
declare(strict_types=1);

// BitcoinBarometer SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class BitcoinBarometerMakeContext
{
    public static function call(array $ctxmap, ?BitcoinBarometerContext $basectx): BitcoinBarometerContext
    {
        return new BitcoinBarometerContext($ctxmap, $basectx);
    }
}
