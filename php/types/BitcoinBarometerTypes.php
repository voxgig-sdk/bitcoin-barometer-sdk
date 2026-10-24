<?php
declare(strict_types=1);

// Typed models for the BitcoinBarometer SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Badge entity data model. */
class Badge
{
    public ?string $color = null;
    public string $label;
    public string $message;
    public int $schemaVersion;
}

/** Request payload for Badge#load. */
class BadgeLoadMatch
{
    public ?string $color = null;
    public ?string $label = null;
    public ?string $message = null;
    public ?int $schemaVersion = null;
}

/** Barometer entity data model. */
class Barometer
{
    public ?int $max = null;
    public ?int $min = null;
    public ?string $zone = null;
}

/** Request payload for Barometer#list. */
class BarometerListMatch
{
    public ?int $max = null;
    public ?int $min = null;
    public ?string $zone = null;
}

