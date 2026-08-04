--[[
  SuperInstance Design System — Spacing (Roblox)
  Modular 4px scale mapped to UDim2 and UDim helpers.
]]

local Spacing = {}

--------------------------------------------------------------------------------
-- Numeric scale (px)
--------------------------------------------------------------------------------
Spacing.Scale = {
  [0] = 0,
  [1] = 4,
  [2] = 8,
  [3] = 12,
  [4] = 16,
  [5] = 20,
  [6] = 24,
  [8] = 32,
  [10] = 40,
  [12] = 48,
  [16] = 64,
  [20] = 80,
  [24] = 96,
  [32] = 128,
}

--------------------------------------------------------------------------------
-- UDim shorthand (absolute offset only)
--------------------------------------------------------------------------------
function Spacing.UDim(pixels)
  return UDim.new(0, pixels)
end

function Spacing.UDim2(width, height)
  return UDim2.new(0, width, 0, height)
end

function Spacing.Offset(scaleKey)
  return Spacing.Scale[scaleKey] or 0
end

--------------------------------------------------------------------------------
-- Precomputed UDim2 tokens (absolute px)
--------------------------------------------------------------------------------
Spacing.UDim2Tokens = {}
for key, px in pairs(Spacing.Scale) do
  Spacing.UDim2Tokens[key] = Spacing.UDim2(px, px)
end

--------------------------------------------------------------------------------
-- Rectangular helpers: Size, Position, Padding
--------------------------------------------------------------------------------
function Spacing.Size(widthKey, heightKey)
  return UDim2.new(0, Spacing.Scale[widthKey] or 0, 0, Spacing.Scale[heightKey] or 0)
end

function Spacing.Position(xKey, yKey)
  return UDim2.new(0, Spacing.Scale[xKey] or 0, 0, Spacing.Scale[yKey] or 0)
end

function Spacing.Padding(all)
  local px = Spacing.Scale[all] or 0
  return {
    Left = px,
    Top = px,
    Right = px,
    Bottom = px,
  }
end

function Spacing.PaddingAxis(horizontal, vertical)
  return {
    Left = Spacing.Scale[horizontal] or 0,
    Top = Spacing.Scale[vertical] or 0,
    Right = Spacing.Scale[horizontal] or 0,
    Bottom = Spacing.Scale[vertical] or 0,
  }
end

--------------------------------------------------------------------------------
-- Corner radius
--------------------------------------------------------------------------------
Spacing.Radius = {
  SM = 4,
  MD = 8,
  LG = 12,
  XL = 16,
  Full = 9999,
}

--------------------------------------------------------------------------------
-- Semantic tokens
--------------------------------------------------------------------------------
Spacing.Gap = {
  XS = Spacing.Scale[1],
  SM = Spacing.Scale[2],
  MD = Spacing.Scale[4],
  LG = Spacing.Scale[6],
  XL = Spacing.Scale[8],
}

Spacing.Pad = {
  XS = Spacing.Scale[1],
  SM = Spacing.Scale[2],
  MD = Spacing.Scale[4],
  LG = Spacing.Scale[6],
  XL = Spacing.Scale[8],
}

return Spacing
