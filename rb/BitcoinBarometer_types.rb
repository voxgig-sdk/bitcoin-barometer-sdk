# frozen_string_literal: true

# Typed models for the BitcoinBarometer SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
# params (op.<name>.points[].g.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Badge entity data model.
#
# @!attribute [rw] color
#   @return [String, nil]
#
# @!attribute [rw] label
#   @return [String]
#
# @!attribute [rw] message
#   @return [String]
#
# @!attribute [rw] schemaVersion
#   @return [Integer]
Badge = Struct.new(
  :color,
  :label,
  :message,
  :schemaVersion,
  keyword_init: true
)

# Request payload for Badge#load.
#
# @!attribute [rw] color
#   @return [String, nil]
#
# @!attribute [rw] label
#   @return [String, nil]
#
# @!attribute [rw] message
#   @return [String, nil]
#
# @!attribute [rw] schemaVersion
#   @return [Integer, nil]
BadgeLoadMatch = Struct.new(
  :color,
  :label,
  :message,
  :schemaVersion,
  keyword_init: true
)

# Barometer entity data model.
#
# @!attribute [rw] max
#   @return [Integer, nil]
#
# @!attribute [rw] min
#   @return [Integer, nil]
#
# @!attribute [rw] zone
#   @return [String, nil]
Barometer = Struct.new(
  :max,
  :min,
  :zone,
  keyword_init: true
)

# Request payload for Barometer#list.
#
# @!attribute [rw] max
#   @return [Integer, nil]
#
# @!attribute [rw] min
#   @return [Integer, nil]
#
# @!attribute [rw] zone
#   @return [String, nil]
BarometerListMatch = Struct.new(
  :max,
  :min,
  :zone,
  keyword_init: true
)

