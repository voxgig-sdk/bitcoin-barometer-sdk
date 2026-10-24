// Typed models for the BitcoinBarometer SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
// params (op.<name>.points[].g.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Badge {
  color?: string
  label: string
  message: string
  schemaVersion: number
}

export interface BadgeLoadMatch {
  color?: string
  label?: string
  message?: string
  schemaVersion?: number
}

export interface Barometer {
  max?: number
  min?: number
  zone?: string
}

export interface BarometerListMatch {
  max?: number
  min?: number
  zone?: string
}

