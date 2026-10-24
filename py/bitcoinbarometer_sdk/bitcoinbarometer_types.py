# Typed models for the BitcoinBarometer SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class BadgeRequired(TypedDict):
    label: str
    message: str
    schemaVersion: int


class Badge(BadgeRequired, total=False):
    color: str


class BadgeLoadMatch(TypedDict, total=False):
    color: str
    label: str
    message: str
    schemaVersion: int


class Barometer(TypedDict, total=False):
    max: int
    min: int
    zone: str


class BarometerListMatch(TypedDict, total=False):
    max: int
    min: int
    zone: str
