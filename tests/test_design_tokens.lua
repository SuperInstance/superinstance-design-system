--[[
  SuperInstance Design System — Lua Module Tests

  These tests validate the data structures and logic of the design system
  modules. They test the token tables and pure functions that don't require
  a Roblox environment (no Instance creation, no TweenService).

  To run: lua5.1 tests/test_design_tokens.lua
]]

-- ─── Mock Roblox Globals ───────────────────────────────────────

-- We mock only what's needed for the token modules (colors, spacing, motion)
-- The component modules (button, card, etc.) require full Roblox services
-- and are tested in-place via the Roblox Studio environment.

local tests_run = 0
local tests_passed = 0
local tests_failed = 0
local failures = {}

local function assert_eq(actual, expected, msg)
  tests_run = tests_run + 1
  if actual == expected then
    tests_passed = tests_passed + 1
  else
    tests_failed = tests_failed + 1
    table.insert(failures, string.format(
      "FAIL: %s — expected %s, got %s",
      msg or "?", tostring(expected), tostring(actual)
    ))
  end
end

local function assert_true(val, msg)
  tests_run = tests_run + 1
  if val then
    tests_passed = tests_passed + 1
  else
    tests_failed = tests_failed + 1
    table.insert(failures, "FAIL: " .. (msg or "expected truthy"))
  end
end

local function assert_ge(actual, expected, msg)
  tests_run = tests_run + 1
  if actual >= expected then
    tests_passed = tests_passed + 1
  else
    tests_failed = tests_failed + 1
    table.insert(failures, string.format(
      "FAIL: %s — expected >= %s, got %s",
      msg or "?", tostring(expected), tostring(actual)
    ))
  end
end

-- ─── Mock Color3 ───────────────────────────────────────────────

local Color3 = {}
Color3.__index = Color3

function Color3.fromHex(hex)
  return setmetatable({hex = hex, r = 0, g = 0, b = 0}, Color3)
end

function Color3.fromRGB(r, g, b)
  return setmetatable({r = r, g = g, b = b, hex = nil}, Color3)
end

-- ─── Mock UDim / UDim2 ─────────────────────────────────────────

local UDim = {}
UDim.__index = UDim

function UDim.new(scale, offset)
  return setmetatable({scale = scale, offset = offset}, UDim)
end

local UDim2 = {}
UDim2.__index = UDim2

function UDim2.new(xScale, xOffset, yScale, yOffset)
  return setmetatable({xScale = xScale, xOffset = xOffset, yScale = yScale, yOffset = yOffset}, UDim2)
end

-- ─── Mock Roblox Enums ─────────────────────────────────────────

local Enum = {
  EasingStyle = {
    Linear = "Linear",
    Sine = "Sine",
    Quart = "Quart",
    Back = "Back",
    Cubic = "Cubic",
  },
  EasingDirection = {
    In = "In",
    Out = "Out",
    InOut = "InOut",
  },
}

-- ─── Mock TweenInfo ────────────────────────────────────────────

local TweenInfo = {}
TweenInfo.__index = TweenInfo

function TweenInfo.new(duration, style, direction)
  return setmetatable({duration = duration, style = style, direction = direction}, TweenInfo)
end

-- ─── Inject Mocks ──────────────────────────────────────────────

-- Store original globals so require() works
_G.Color3 = Color3
_G.UDim = UDim
_G.UDim2 = UDim2
_G.Enum = Enum
_G.TweenInfo = TweenInfo
_G.warn = function(msg) end  -- suppress warnings in tests

-- ─── Load Design System Modules ────────────────────────────────

package.path = package.path .. ";./src/?.lua;./src/colors.lua;./src/spacing.lua;./src/motion.lua"

local script_dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
local src_dir = script_dir .. "../src/"

-- Load colors
local Colors = dofile(src_dir .. "colors.lua")
local Spacing = dofile(src_dir .. "spacing.lua")
local Motion = dofile(src_dir .. "motion.lua")

-- ─── Colors Tests ──────────────────────────────────────────────

print("=== Colors Module ===")

-- Palette structure
assert_true(Colors.Palette ~= nil, "Colors.Palette should exist")
assert_true(Colors.Palette.Harbor ~= nil, "Harbor palette should exist")
assert_true(Colors.Palette.Water ~= nil, "Water palette should exist")
assert_true(Colors.Palette.Wood ~= nil, "Wood palette should exist")
assert_true(Colors.Palette.Amber ~= nil, "Amber palette should exist")
assert_true(Colors.Palette.Foam ~= nil, "Foam palette should exist")
assert_true(Colors.Palette.Rust ~= nil, "Rust palette should exist")

-- Palette completeness (each has 10 shades: 50-900)
for _, name in ipairs({"Harbor", "Water", "Wood", "Amber", "Foam", "Rust"}) do
  local palette = Colors.Palette[name]
  for _, shade in ipairs({50, 100, 200, 300, 400, 500, 600, 700, 800, 900}) do
    assert_true(palette[shade] ~= nil,
      name .. "[" .. shade .. "] should exist")
  end
end

-- Semantic aliases
assert_true(Colors.Semantic ~= nil, "Semantic colors should exist")
assert_eq(Colors.Semantic.Success, Colors.Palette.Foam, "Success = Foam")
assert_eq(Colors.Semantic.Warning, Colors.Palette.Amber, "Warning = Amber")
assert_eq(Colors.Semantic.Danger, Colors.Palette.Rust, "Danger = Rust")
assert_eq(Colors.Semantic.Info, Colors.Palette.Water, "Info = Water")

-- Themes
assert_true(Colors.Theme ~= nil, "Theme should exist")
assert_true(Colors.Theme.Light ~= nil, "Light theme should exist")
assert_true(Colors.Theme.Dark ~= nil, "Dark theme should exist")

-- Theme tokens
local lightTheme = Colors.Theme.Light
assert_true(lightTheme.BgPrimary ~= nil, "Light.BgPrimary should exist")
assert_true(lightTheme.FgPrimary ~= nil, "Light.FgPrimary should exist")
assert_true(lightTheme.AccentPrimary ~= nil, "Light.AccentPrimary should exist")
assert_true(lightTheme.BorderDefault ~= nil, "Light.BorderDefault should exist")

local darkTheme = Colors.Theme.Dark
assert_true(darkTheme.BgPrimary ~= nil, "Dark.BgPrimary should exist")
assert_true(darkTheme.FgPrimary ~= nil, "Dark.FgPrimary should exist")

-- Theme switching
Colors.SetTheme("Dark")
assert_eq(Colors.Current, "Dark", "Current theme should be Dark after SetTheme")
Colors.SetTheme("Light")
assert_eq(Colors.Current, "Light", "Current theme should be Light after SetTheme")

-- GetTheme returns current theme
local theme = Colors.GetTheme()
assert_eq(theme, Colors.Theme.Light, "GetTheme should return current theme")

-- Invalid theme warns and doesn't change
Colors.SetTheme("InvalidTheme")
assert_eq(Colors.Current, "Light", "Invalid theme should not change current")

print("  " .. tests_passed .. " color assertions passed")

-- ─── Spacing Tests ─────────────────────────────────────────────

print("=== Spacing Module ===")

-- Scale exists and has correct values
assert_eq(Spacing.Scale[0], 0, "Scale[0] = 0px")
assert_eq(Spacing.Scale[1], 4, "Scale[1] = 4px")
assert_eq(Spacing.Scale[2], 8, "Scale[2] = 8px")
assert_eq(Spacing.Scale[4], 16, "Scale[4] = 16px")
assert_eq(Spacing.Scale[8], 32, "Scale[8] = 32px")
assert_eq(Spacing.Scale[16], 64, "Scale[16] = 64px")
assert_eq(Spacing.Scale[32], 128, "Scale[32] = 128px")

-- 4px modular scale
for k, v in pairs(Spacing.Scale) do
  if k > 0 then
    assert_eq(v % 4, 0, "Scale[" .. k .. "] = " .. v .. " should be divisible by 4")
  end
end

-- Offset returns scale value
assert_eq(Spacing.Offset(4), 16, "Offset(4) = 16")
assert_eq(Spacing.Offset(0), 0, "Offset(0) = 0")
assert_eq(Spacing.Offset(999), 0, "Offset(999) = 0 for unknown key")

-- UDim helpers
local ud = Spacing.UDim(20)
assert_eq(ud.offset, 20, "UDim(20).offset = 20")
assert_eq(ud.scale, 0, "UDim(20).scale = 0")

local ud2 = Spacing.UDim2(100, 50)
assert_eq(ud2.xOffset, 100, "UDim2(100,50).xOffset = 100")
assert_eq(ud2.yOffset, 50, "UDim2(100,50).yOffset = 50")

-- Size helper
local size = Spacing.Size(4, 6)
assert_eq(size.xOffset, 16, "Size(4,6).xOffset = 16")
assert_eq(size.yOffset, 24, "Size(4,6).yOffset = 24")

-- Position helper
local pos = Spacing.Position(2, 3)
assert_eq(pos.xOffset, 8, "Position(2,3).xOffset = 8")
assert_eq(pos.yOffset, 12, "Position(2,3).yOffset = 12")

-- Padding helper
local pad = Spacing.Padding(4)
assert_eq(pad.Left, 16, "Padding(4).Left = 16")
assert_eq(pad.Right, 16, "Padding(4).Right = 16")
assert_eq(pad.Top, 16, "Padding(4).Top = 16")
assert_eq(pad.Bottom, 16, "Padding(4).Bottom = 16")

-- PaddingAxis helper
local padAxis = Spacing.PaddingAxis(4, 2)
assert_eq(padAxis.Left, 16, "PaddingAxis(4,2).Left = 16")
assert_eq(padAxis.Top, 8, "PaddingAxis(4,2).Top = 8")

-- Radius
assert_eq(Spacing.Radius.SM, 4, "Radius.SM = 4")
assert_eq(Spacing.Radius.MD, 8, "Radius.MD = 8")
assert_eq(Spacing.Radius.LG, 12, "Radius.LG = 12")
assert_eq(Spacing.Radius.XL, 16, "Radius.XL = 16")
assert_eq(Spacing.Radius.Full, 9999, "Radius.Full = 9999")

-- Semantic gap tokens
assert_eq(Spacing.Gap.XS, 4, "Gap.XS = 4")
assert_eq(Spacing.Gap.SM, 8, "Gap.SM = 8")
assert_eq(Spacing.Gap.MD, 16, "Gap.MD = 16")
assert_eq(Spacing.Gap.LG, 24, "Gap.LG = 24")
assert_eq(Spacing.Gap.XL, 32, "Gap.XL = 32")

-- Semantic pad tokens
assert_eq(Spacing.Pad.XS, 4, "Pad.XS = 4")
assert_eq(Spacing.Pad.MD, 16, "Pad.MD = 16")

print("  " .. tests_passed - 40 .. " spacing assertions passed (40 cumulative)")

-- ─── Motion Tests ──────────────────────────────────────────────

print("=== Motion Module ===")

-- Easing styles mapped
assert_eq(Motion.Easing.Linear, Enum.EasingStyle.Linear, "Easing.Linear")
assert_eq(Motion.Easing.In, Enum.EasingStyle.Sine, "Easing.In = Sine")
assert_eq(Motion.Easing.Out, Enum.EasingStyle.Quart, "Easing.Out = Quart")
assert_eq(Motion.Easing.Spring, Enum.EasingStyle.Back, "Easing.Spring = Back")

-- Duration scale
assert_eq(Motion.Duration.Instant, 0, "Duration.Instant = 0")
assert_eq(Motion.Duration.Fast, 0.1, "Duration.Fast = 0.1")
assert_eq(Motion.Duration.Base, 0.2, "Duration.Base = 0.2")
assert_eq(Motion.Duration.Normal, 0.3, "Duration.Normal = 0.3")
assert_eq(Motion.Duration.Slow, 0.5, "Duration.Slow = 0.5")
assert_eq(Motion.Duration.Slower, 0.7, "Duration.Slower = 0.7")

-- Stagger scale
assert_eq(Motion.Stagger.Tight, 0.03, "Stagger.Tight = 0.03")
assert_eq(Motion.Stagger.Base, 0.05, "Stagger.Base = 0.05")
assert_eq(Motion.Stagger.Loose, 0.1, "Stagger.Loose = 0.1")

-- TweenInfo tokens exist and have correct durations
assert_true(Motion.Tweens.Instant ~= nil, "Tweens.Instant should exist")
assert_eq(Motion.Tweens.Instant.duration, 0, "Tweens.Instant.duration = 0")

assert_true(Motion.Tweens.Fast ~= nil, "Tweens.Fast should exist")
assert_eq(Motion.Tweens.Fast.duration, 0.1, "Tweens.Fast.duration = 0.1")

assert_true(Motion.Tweens.Normal ~= nil, "Tweens.Normal should exist")
assert_eq(Motion.Tweens.Normal.duration, 0.3, "Tweens.Normal.duration = 0.3")

assert_true(Motion.Tweens.Slow ~= nil, "Tweens.Slow should exist")
assert_eq(Motion.Tweens.Slow.duration, 0.5, "Tweens.Slow.duration = 0.5")

assert_true(Motion.Tweens.Spring ~= nil, "Tweens.Spring should exist")
assert_eq(Motion.Tweens.Spring.style, Enum.EasingStyle.Back, "Tweens.Spring.style = Back")

-- Build helper
local custom = Motion.Build(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
assert_eq(custom.duration, 0.4, "Build(0.4,...).duration = 0.4")
assert_eq(custom.style, Enum.EasingStyle.Cubic, "Build style = Cubic")
assert_eq(custom.direction, Enum.EasingDirection.InOut, "Build direction = InOut")

-- Build with defaults
local default = Motion.Build(0.3)
assert_eq(default.style, Enum.EasingStyle.Quart, "Build default style = Quart (Out)")
assert_eq(default.direction, Enum.EasingDirection.Out, "Build default direction = Out")

print("  " .. tests_passed - 70 .. " motion assertions passed (70 cumulative)")

-- ─── Summary ───────────────────────────────────────────────────

print("\n" .. string.rep("=", 50))
print(string.format("Total: %d run, %d passed, %d failed",
  tests_run, tests_passed, tests_failed))

if #failures > 0 then
  print("\nFAILURES:")
  for _, f in ipairs(failures) do
    print("  " .. f)
  end
  os.exit(1)
else
  print("All tests passed! ✅")
end
