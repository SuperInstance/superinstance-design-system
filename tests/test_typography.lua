--[[
  SuperInstance Design System — Typography Tests

  Tests typography token tables: families, sizes, weights, line heights,
  tracking, preset styles, and Apply() with a mock instance.

  To run: lua5.1 tests/test_typography.lua
]]

-- ─── Mock Roblox Globals ───────────────────────────────────────

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

local function assert_ne(actual, expected, msg)
  tests_run = tests_run + 1
  if actual ~= expected then
    tests_passed = tests_passed + 1
  else
    tests_failed = tests_failed + 1
    table.insert(failures, string.format(
      "FAIL: %s — expected not %s, got %s",
      msg or "?", tostring(expected), tostring(actual)
    ))
  end
end

-- ─── Mock Roblox Globals ───────────────────────────────────────

local Enum = {
  Font = {
    Gotham = "Gotham",
    Garamond = "Garamond",
    Code = "Code",
    GothamBlack = "GothamBlack",
    GothamMedium = "GothamMedium",
    GothamSemibold = "GothamSemibold",
    GothamBold = "GothamBold",
  },
}

local Color3 = {}
Color3.__index = Color3
function Color3.fromHex(hex) return setmetatable({hex = hex}, Color3) end
function Color3.fromRGB(r, g, b) return setmetatable({r = r, g = g, b = b}, Color3) end

local UDim = {}
UDim.__index = UDim
function UDim.new(scale, offset) return setmetatable({scale = scale, offset = offset}, UDim) end

local UDim2 = {}
UDim2.__index = UDim2
function UDim2.new(xS, xO, yS, yO) return setmetatable({xScale = xS, xOffset = xO, yScale = yS, yOffset = yO}, UDim2) end

local TweenInfo = {}
TweenInfo.__index = TweenInfo
function TweenInfo.new(d, s, dir) return setmetatable({duration = d, style = s, direction = dir}, TweenInfo) end

_G.Enum = Enum
_G.Color3 = Color3
_G.UDim = UDim
_G.UDim2 = UDim2
_G.TweenInfo = TweenInfo
_G.warn = function() end

-- ─── Load Module ───────────────────────────────────────────────

local script_dir = debug.getinfo(1, "S").source:match("@(.*/)") or "./"
local src_dir = script_dir .. "../src/"
local Typography = dofile(src_dir .. "typography.lua")

-- ─── Typeface Family Tests ─────────────────────────────────────

print("=== Typography Family ===")

assert_eq(Typography.Family.Sans, Enum.Font.Gotham, "Sans = Gotham")
assert_eq(Typography.Family.Serif, Enum.Font.Garamond, "Serif = Garamond")
assert_eq(Typography.Family.Mono, Enum.Font.Code, "Mono = Code")
assert_eq(Typography.Family.Display, Enum.Font.GothamBlack, "Display = GothamBlack")

-- ─── Type Scale Tests ──────────────────────────────────────────

print("=== Typography Size Scale ===")

assert_eq(Typography.Size.XS, 12, "XS = 12")
assert_eq(Typography.Size.SM, 14, "SM = 14")
assert_eq(Typography.Size.Base, 16, "Base = 16")
assert_eq(Typography.Size.LG, 18, "LG = 18")
assert_eq(Typography.Size.XL, 20, "XL = 20")
assert_eq(Typography.Size._2XL, 24, "2XL = 24")
assert_eq(Typography.Size._3XL, 30, "3XL = 30")
assert_eq(Typography.Size._4XL, 36, "4XL = 36")
assert_eq(Typography.Size._5XL, 48, "5XL = 48")
assert_eq(Typography.Size._6XL, 60, "6XL = 60")

-- Monotonic increase
local sizes = {12, 14, 16, 18, 20, 24, 30, 36, 48, 60}
local keys = {"XS", "SM", "Base", "LG", "XL", "_2XL", "_3XL", "_4XL", "_5XL", "_6XL"}
for i = 2, #keys do
  assert_true(Typography.Size[keys[i]] > Typography.Size[keys[i-1]],
    keys[i] .. " > " .. keys[i-1])
end

-- ─── Weight Tests ──────────────────────────────────────────────

print("=== Typography Weight ===")

assert_eq(Typography.Weight.Normal, Enum.Font.Gotham, "Normal = Gotham")
assert_eq(Typography.Weight.Medium, Enum.Font.GothamMedium, "Medium = GothamMedium")
assert_eq(Typography.Weight.Semibold, Enum.Font.GothamSemibold, "Semibold = GothamSemibold")
assert_eq(Typography.Weight.Bold, Enum.Font.GothamBold, "Bold = GothamBold")
assert_eq(Typography.Weight.Black, Enum.Font.GothamBlack, "Black = GothamBlack")

-- ─── Line Height Tests ─────────────────────────────────────────

print("=== Typography LineHeight ===")

assert_eq(Typography.LineHeight.None, 1, "None = 1")
assert_eq(Typography.LineHeight.Tight, 1.25, "Tight = 1.25")
assert_eq(Typography.LineHeight.Snug, 1.375, "Snug = 1.375")
assert_eq(Typography.LineHeight.Normal, 1.5, "Normal = 1.5")
assert_eq(Typography.LineHeight.Relaxed, 1.625, "Relaxed = 1.625")
assert_eq(Typography.LineHeight.Loose, 2, "Loose = 2")

-- Monotonic: None < Tight < Snug < Normal < Relaxed < Loose
assert_true(Typography.LineHeight.None < Typography.LineHeight.Tight, "None < Tight")
assert_true(Typography.LineHeight.Tight < Typography.LineHeight.Snug, "Tight < Snug")
assert_true(Typography.LineHeight.Snug < Typography.LineHeight.Normal, "Snug < Normal")
assert_true(Typography.LineHeight.Normal < Typography.LineHeight.Relaxed, "Normal < Relaxed")
assert_true(Typography.LineHeight.Relaxed < Typography.LineHeight.Loose, "Relaxed < Loose")

-- ─── Tracking Tests ────────────────────────────────────────────

print("=== Typography Tracking ===")

assert_eq(Typography.Tracking.Tighter, -0.05, "Tighter = -0.05")
assert_eq(Typography.Tracking.Tight, -0.025, "Tight = -0.025")
assert_eq(Typography.Tracking.Normal, 0, "Normal = 0")
assert_eq(Typography.Tracking.Wide, 0.025, "Wide = 0.025")
assert_eq(Typography.Tracking.Wider, 0.05, "Wider = 0.05")
assert_eq(Typography.Tracking.Widest, 0.1, "Widest = 0.1")

-- Monotonic
assert_true(Typography.Tracking.Tighter < Typography.Tracking.Tight, "Tighter < Tight")
assert_true(Typography.Tracking.Tight < Typography.Tracking.Normal, "Tight < Normal")
assert_true(Typography.Tracking.Normal < Typography.Tracking.Wide, "Normal < Wide")
assert_true(Typography.Tracking.Wide < Typography.Tracking.Wider, "Wide < Wider")
assert_true(Typography.Tracking.Wider < Typography.Tracking.Widest, "Wider < Widest")

-- ─── Preset Styles Tests ───────────────────────────────────────

print("=== Typography Preset Styles ===")

-- All styles exist
local style_names = {"Display", "H1", "H2", "H3", "H4", "H5", "H6",
                     "Body", "BodyLg", "BodySm", "Article", "Code", "Data",
                     "Label", "Dialogue"}
for _, name in ipairs(style_names) do
  assert_true(Typography.Styles[name] ~= nil, "Style '" .. name .. "' exists")
  assert_true(Typography.Styles[name].Font ~= nil, name .. ".Font exists")
  assert_true(Typography.Styles[name].Size ~= nil, name .. ".Size exists")
  assert_true(Typography.Styles[name].Weight ~= nil, name .. ".Weight exists")
  assert_true(Typography.Styles[name].LineHeight ~= nil, name .. ".LineHeight exists")
  assert_true(Typography.Styles[name].Tracking ~= nil, name .. ".Tracking exists")
end

-- Display is the largest
assert_eq(Typography.Styles.Display.Size, Typography.Size._6XL, "Display size = 6XL (60)")
assert_eq(Typography.Styles.Display.Font, Typography.Family.Display, "Display font = Display family")

-- H1 is second largest
assert_eq(Typography.Styles.H1.Size, Typography.Size._5XL, "H1 size = 5XL (48)")
assert_eq(Typography.Styles.H1.Font, Typography.Family.Sans, "H1 font = Sans")

-- Body uses Base size
assert_eq(Typography.Styles.Body.Size, Typography.Size.Base, "Body size = Base (16)")
assert_eq(Typography.Styles.Body.Font, Typography.Family.Sans, "Body font = Sans")

-- Code uses Mono
assert_eq(Typography.Styles.Code.Font, Typography.Family.Mono, "Code font = Mono")
assert_eq(Typography.Styles.Code.Size, Typography.Size.SM, "Code size = SM (14)")

-- Article and Dialogue use Serif
assert_eq(Typography.Styles.Article.Font, Typography.Family.Serif, "Article font = Serif")
assert_eq(Typography.Styles.Dialogue.Font, Typography.Family.Serif, "Dialogue font = Serif")

-- Data uses Mono + Medium weight
assert_eq(Typography.Styles.Data.Font, Typography.Family.Mono, "Data font = Mono")
assert_eq(Typography.Styles.Data.Weight, Typography.Weight.Medium, "Data weight = Medium")

-- Label uses smallest size + Semibold + Wider tracking
assert_eq(Typography.Styles.Label.Size, Typography.Size.XS, "Label size = XS (12)")
assert_eq(Typography.Styles.Label.Weight, Typography.Weight.Semibold, "Label weight = Semibold")
assert_eq(Typography.Styles.Label.Tracking, Typography.Tracking.Wider, "Label tracking = Wider")

-- Heading hierarchy: each heading is smaller than the last
assert_true(Typography.Styles.H1.Size > Typography.Styles.H2.Size, "H1 > H2")
assert_true(Typography.Styles.H2.Size > Typography.Styles.H3.Size, "H2 > H3")
assert_true(Typography.Styles.H3.Size > Typography.Styles.H4.Size, "H3 > H4")
assert_true(Typography.Styles.H4.Size > Typography.Styles.H5.Size, "H4 > H5")
assert_true(Typography.Styles.H5.Size > Typography.Styles.H6.Size, "H5 > H6")

-- BodyLg > Body > BodySm
assert_true(Typography.Styles.BodyLg.Size > Typography.Styles.Body.Size, "BodyLg > Body")
assert_true(Typography.Styles.Body.Size > Typography.Styles.BodySm.Size, "Body > BodySm")

-- ─── Apply() Tests ─────────────────────────────────────────────

print("=== Typography.Apply() ===")

-- Mock instance
local function makeMockInstance()
  return {
    Font = nil,
    TextSize = nil,
    LineHeight = nil,
    _attributes = {},
    SetAttribute = function(self, key, val) self._attributes[key] = val end,
    GetAttribute = function(self, key) return self._attributes[key] end,
  }
end

-- Apply Body style
local inst = makeMockInstance()
Typography.Apply(inst, "Body")
assert_eq(inst.Font, Typography.Family.Sans, "Apply Body: Font = Sans")
assert_eq(inst.TextSize, Typography.Size.Base, "Apply Body: TextSize = 16")
assert_eq(inst.LineHeight, Typography.LineHeight.Relaxed, "Apply Body: LineHeight = Relaxed")
assert_eq(inst:GetAttribute("Tracking"), Typography.Tracking.Normal, "Apply Body: Tracking = Normal")

-- Apply Display style
local inst2 = makeMockInstance()
Typography.Apply(inst2, "Display")
assert_eq(inst2.TextSize, Typography.Size._6XL, "Apply Display: TextSize = 60")

-- Apply Code style
local inst3 = makeMockInstance()
Typography.Apply(inst3, "Code")
assert_eq(inst3.Font, Typography.Family.Mono, "Apply Code: Font = Mono")
assert_eq(inst3.TextSize, Typography.Size.SM, "Apply Code: TextSize = 14")

-- Apply with invalid style — should warn but not crash
local inst4 = makeMockInstance()
Typography.Apply(inst4, "NonExistentStyle")
assert_eq(inst4.Font, nil, "Apply invalid: Font unchanged (nil)")
assert_eq(inst4.TextSize, nil, "Apply invalid: TextSize unchanged (nil)")

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
  print("All typography tests passed! ✅")
end
