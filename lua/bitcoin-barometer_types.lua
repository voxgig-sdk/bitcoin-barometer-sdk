-- Typed models for the BitcoinBarometer SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields{} and per-op
-- params (op.<name>.points[].g.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Badge
---@field color? string
---@field label string
---@field message string
---@field schemaVersion number

---@class BadgeLoadMatch
---@field color? string
---@field label? string
---@field message? string
---@field schemaVersion? number

---@class Barometer
---@field max? number
---@field min? number
---@field zone? string

---@class BarometerListMatch
---@field max? number
---@field min? number
---@field zone? string

local M = {}

return M
