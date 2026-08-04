--[[
  SuperInstance Design System — Typography (Roblox)
  Maritime harbor identity engineered for technical clarity.
]]

local Typography = {}

--------------------------------------------------------------------------------
-- Typeface tokens
--------------------------------------------------------------------------------
Typography.Family = {
  Sans = Enum.Font.Gotham,          -- UI, headings, labels
  Serif = Enum.Font.Garamond,       -- Long-form, dialogue, lore
  Mono = Enum.Font.Code,            -- Code, data, telemetry
  Display = Enum.Font.GothamBlack,  -- Hero / display headlines
}

--------------------------------------------------------------------------------
-- Type scale (in pixels, approximating the web Major Third scale)
--------------------------------------------------------------------------------
Typography.Size = {
  XS = 12,
  SM = 14,
  Base = 16,
  LG = 18,
  XL = 20,
  _2XL = 24,
  _3XL = 30,
  _4XL = 36,
  _5XL = 48,
  _6XL = 60,
}

--------------------------------------------------------------------------------
-- Weights (Roblox uses Font enum; weight is controlled by family choice)
--------------------------------------------------------------------------------
Typography.Weight = {
  Normal = Enum.Font.Gotham,
  Medium = Enum.Font.GothamMedium,
  Semibold = Enum.Font.GothamSemibold,
  Bold = Enum.Font.GothamBold,
  Black = Enum.Font.GothamBlack,
}

--------------------------------------------------------------------------------
-- Line heights (absolute px values)
--------------------------------------------------------------------------------
Typography.LineHeight = {
  None = 1,
  Tight = 1.25,
  Snug = 1.375,
  Normal = 1.5,
  Relaxed = 1.625,
  Loose = 2,
}

--------------------------------------------------------------------------------
-- Letter spacing (in em proportions; apply as pixel offsets where needed)
--------------------------------------------------------------------------------
Typography.Tracking = {
  Tighter = -0.05,
  Tight = -0.025,
  Normal = 0,
  Wide = 0.025,
  Wider = 0.05,
  Widest = 0.1,
}

--------------------------------------------------------------------------------
-- Preset styles (applicable to TextLabels / TextButtons / TextBoxes)
--------------------------------------------------------------------------------
Typography.Styles = {
  Display = {
    Font = Typography.Family.Display,
    Size = Typography.Size._6XL,
    Weight = Typography.Weight.Black,
    LineHeight = Typography.LineHeight.None,
    Tracking = Typography.Tracking.Tight,
  },
  H1 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size._5XL,
    Weight = Typography.Weight.Bold,
    LineHeight = Typography.LineHeight.Tight,
    Tracking = Typography.Tracking.Tight,
  },
  H2 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size._4XL,
    Weight = Typography.Weight.Bold,
    LineHeight = Typography.LineHeight.Tight,
    Tracking = Typography.Tracking.Tight,
  },
  H3 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size._3XL,
    Weight = Typography.Weight.Semibold,
    LineHeight = Typography.LineHeight.Snug,
    Tracking = Typography.Tracking.Normal,
  },
  H4 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size._2XL,
    Weight = Typography.Weight.Semibold,
    LineHeight = Typography.LineHeight.Snug,
    Tracking = Typography.Tracking.Normal,
  },
  H5 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.XL,
    Weight = Typography.Weight.Semibold,
    LineHeight = Typography.LineHeight.Snug,
    Tracking = Typography.Tracking.Normal,
  },
  H6 = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.LG,
    Weight = Typography.Weight.Semibold,
    LineHeight = Typography.LineHeight.Normal,
    Tracking = Typography.Tracking.Wide,
  },
  Body = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.Base,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Relaxed,
    Tracking = Typography.Tracking.Normal,
  },
  BodyLg = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.LG,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Relaxed,
    Tracking = Typography.Tracking.Normal,
  },
  BodySm = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.SM,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Normal,
    Tracking = Typography.Tracking.Normal,
  },
  Article = {
    Font = Typography.Family.Serif,
    Size = Typography.Size.LG,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Loose,
    Tracking = Typography.Tracking.Normal,
  },
  Code = {
    Font = Typography.Family.Mono,
    Size = Typography.Size.SM,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Normal,
    Tracking = Typography.Tracking.Normal,
  },
  Data = {
    Font = Typography.Family.Mono,
    Size = Typography.Size.SM,
    Weight = Typography.Weight.Medium,
    LineHeight = Typography.LineHeight.Normal,
    Tracking = Typography.Tracking.Wide,
  },
  Label = {
    Font = Typography.Family.Sans,
    Size = Typography.Size.XS,
    Weight = Typography.Weight.Semibold,
    LineHeight = Typography.LineHeight.Normal,
    Tracking = Typography.Tracking.Wider,
  },
  Dialogue = {
    Font = Typography.Family.Serif,
    Size = Typography.Size.LG,
    Weight = Typography.Weight.Normal,
    LineHeight = Typography.LineHeight.Relaxed,
    Tracking = Typography.Tracking.Normal,
  },
}

--------------------------------------------------------------------------------
-- Helper to apply a style table to a Roblox text instance
--------------------------------------------------------------------------------
function Typography.Apply(instance, styleName)
  local style = Typography.Styles[styleName]
  if not style then
    warn("[SuperInstance] Unknown typography style: " .. tostring(styleName))
    return
  end

  instance.Font = style.Font
  instance.TextSize = style.Size
  instance.LineHeight = style.LineHeight
  -- Roblox has no direct letter-spacing property; use TextStroke or manual kerning
  -- when exact tracking is required. Tracking value is exposed for custom layouts.
  instance:SetAttribute("Tracking", style.Tracking)
end

return Typography
