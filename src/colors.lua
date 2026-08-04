--[[
  SuperInstance Design System — Colors (Roblox)
  Maritime palette: deep water blues, harbor greys, dock wood browns,
  lantern amber, sea foam, rust.
]]

local Colors = {}

--------------------------------------------------------------------------------
-- Raw palette (Color3.fromHex values)
--------------------------------------------------------------------------------
Colors.Palette = {
  Harbor = {
    [50]  = Color3.fromHex("#f8f9fa"),
    [100] = Color3.fromHex("#f1f3f5"),
    [200] = Color3.fromHex("#e9ecef"),
    [300] = Color3.fromHex("#dee2e6"),
    [400] = Color3.fromHex("#adb5bd"),
    [500] = Color3.fromHex("#868e96"),
    [600] = Color3.fromHex("#495057"),
    [700] = Color3.fromHex("#343a40"),
    [800] = Color3.fromHex("#212529"),
    [900] = Color3.fromHex("#0b0d0f"),
  },
  Water = {
    [50]  = Color3.fromHex("#f0f7ff"),
    [100] = Color3.fromHex("#d0e8ff"),
    [200] = Color3.fromHex("#9fd2ff"),
    [300] = Color3.fromHex("#5eb5f7"),
    [400] = Color3.fromHex("#2b94e1"),
    [500] = Color3.fromHex("#0f74c2"),
    [600] = Color3.fromHex("#0b5a9e"),
    [700] = Color3.fromHex("#0a406e"),
    [800] = Color3.fromHex("#072a48"),
    [900] = Color3.fromHex("#04162a"),
  },
  Wood = {
    [50]  = Color3.fromHex("#f6f2ee"),
    [100] = Color3.fromHex("#ebe2da"),
    [200] = Color3.fromHex("#d6c4b4"),
    [300] = Color3.fromHex("#bfa08a"),
    [400] = Color3.fromHex("#a67d62"),
    [500] = Color3.fromHex("#8d6e63"),
    [600] = Color3.fromHex("#6d4c41"),
    [700] = Color3.fromHex("#5d4037"),
    [800] = Color3.fromHex("#3e2723"),
    [900] = Color3.fromHex("#21120e"),
  },
  Amber = {
    [50]  = Color3.fromHex("#fffbeb"),
    [100] = Color3.fromHex("#fef3c7"),
    [200] = Color3.fromHex("#fde68a"),
    [300] = Color3.fromHex("#fcd34d"),
    [400] = Color3.fromHex("#fbbf24"),
    [500] = Color3.fromHex("#f59e0b"),
    [600] = Color3.fromHex("#d97706"),
    [700] = Color3.fromHex("#b45309"),
    [800] = Color3.fromHex("#92400e"),
    [900] = Color3.fromHex("#78350f"),
  },
  Foam = {
    [50]  = Color3.fromHex("#f0fdfa"),
    [100] = Color3.fromHex("#ccfbf1"),
    [200] = Color3.fromHex("#99f6e4"),
    [300] = Color3.fromHex("#5eead4"),
    [400] = Color3.fromHex("#2dd4bf"),
    [500] = Color3.fromHex("#14b8a6"),
    [600] = Color3.fromHex("#0d9488"),
    [700] = Color3.fromHex("#0f766e"),
    [800] = Color3.fromHex("#115e59"),
    [900] = Color3.fromHex("#134e4a"),
  },
  Rust = {
    [50]  = Color3.fromHex("#fff7ed"),
    [100] = Color3.fromHex("#ffedd5"),
    [200] = Color3.fromHex("#fed7aa"),
    [300] = Color3.fromHex("#fdba74"),
    [400] = Color3.fromHex("#fb923c"),
    [500] = Color3.fromHex("#f97316"),
    [600] = Color3.fromHex("#ea580c"),
    [700] = Color3.fromHex("#c2410c"),
    [800] = Color3.fromHex("#9a3412"),
    [900] = Color3.fromHex("#7c2d12"),
  },
}

--------------------------------------------------------------------------------
-- Semantic aliases
--------------------------------------------------------------------------------
Colors.Semantic = {
  Success = Colors.Palette.Foam,
  Warning = Colors.Palette.Amber,
  Danger = Colors.Palette.Rust,
  Info = Colors.Palette.Water,
}

--------------------------------------------------------------------------------
-- Theme tokens
--------------------------------------------------------------------------------
Colors.Theme = {
  Light = {
    BgPrimary = Colors.Palette.Harbor[50],
    BgSecondary = Colors.Palette.Harbor[100],
    BgTertiary = Colors.Palette.Harbor[200],
    BgInverted = Colors.Palette.Harbor[900],
    BgSurface = Color3.fromHex("#ffffff"),
    BgOverlay = Color3.fromRGB(11, 13, 15),
    BgWater = Colors.Palette.Water[900],

    FgPrimary = Colors.Palette.Harbor[900],
    FgSecondary = Colors.Palette.Harbor[600],
    FgTertiary = Colors.Palette.Harbor[400],
    FgInverted = Colors.Palette.Harbor[50],
    FgLink = Colors.Palette.Water[600],
    FgLinkHover = Colors.Palette.Water[700],

    BorderSubtle = Colors.Palette.Harbor[200],
    BorderDefault = Colors.Palette.Harbor[300],
    BorderStrong = Colors.Palette.Harbor[400],

    AccentPrimary = Colors.Palette.Water[600],
    AccentPrimaryHover = Colors.Palette.Water[700],
    AccentSecondary = Colors.Palette.Wood[600],
    AccentAmber = Colors.Palette.Amber[500],
    AccentFoam = Colors.Palette.Foam[500],

    ShadowColor = Color3.fromRGB(134, 142, 150),
  },
  Dark = {
    BgPrimary = Colors.Palette.Harbor[900],
    BgSecondary = Colors.Palette.Harbor[800],
    BgTertiary = Colors.Palette.Harbor[700],
    BgInverted = Colors.Palette.Harbor[50],
    BgSurface = Colors.Palette.Harbor[800],
    BgOverlay = Color3.fromRGB(0, 0, 0),
    BgWater = Color3.fromHex("#02080f"),

    FgPrimary = Colors.Palette.Harbor[50],
    FgSecondary = Colors.Palette.Harbor[300],
    FgTertiary = Colors.Palette.Harbor[500],
    FgInverted = Colors.Palette.Harbor[900],
    FgLink = Colors.Palette.Water[300],
    FgLinkHover = Colors.Palette.Water[200],

    BorderSubtle = Colors.Palette.Harbor[700],
    BorderDefault = Colors.Palette.Harbor[600],
    BorderStrong = Colors.Palette.Harbor[500],

    AccentPrimary = Colors.Palette.Water[400],
    AccentPrimaryHover = Colors.Palette.Water[300],
    AccentSecondary = Colors.Palette.Wood[400],
    AccentAmber = Colors.Palette.Amber[400],
    AccentFoam = Colors.Palette.Foam[400],

    ShadowColor = Color3.fromRGB(0, 0, 0),
  },
}

--------------------------------------------------------------------------------
-- Current theme setter / getter
--------------------------------------------------------------------------------
Colors.Current = "Light"

function Colors.GetTheme()
  return Colors.Theme[Colors.Current]
end

function Colors.SetTheme(themeName)
  if not Colors.Theme[themeName] then
    warn("[SuperInstance] Unknown theme: " .. tostring(themeName))
    return
  end
  Colors.Current = themeName
end

return Colors
