--[[
  SuperInstance — Badge (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Typography = require(Design:WaitForChild("typography"))

local Badge = {}

function Badge.New(parent, config)
  config = config or {}
  local variant = config.variant or "default"
  local text = config.text or "Badge"

  local variants = {
    default = { bg = Colors.Palette.Harbor[200], fg = Colors.Palette.Harbor[700] },
    info = { bg = Colors.Semantic.Info[100], fg = Colors.Semantic.Info[900] },
    success = { bg = Colors.Semantic.Success[100], fg = Colors.Semantic.Success[900] },
    warning = { bg = Colors.Semantic.Warning[100], fg = Colors.Semantic.Warning[900] },
    danger = { bg = Colors.Semantic.Danger[100], fg = Colors.Semantic.Danger[900] },
    amber = { bg = Colors.Palette.Amber[100], fg = Colors.Palette.Amber[900] },
  }

  local style = variants[variant]

  local badge = Instance.new("TextLabel")
  badge.Name = config.name or "SiBadge"
  badge.Parent = parent
  badge.Text = text
  badge.TextColor3 = style.fg
  badge.BackgroundColor3 = style.bg
  badge.BorderSizePixel = 0
  badge.Size = UDim2.new(0, 0, 0, 0)
  badge.AutomaticSize = Enum.AutomaticSize.XY
  Typography.Apply(badge, "Label")

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, Spacing.Pad.SM)
  pad.PaddingRight = UDim.new(0, Spacing.Pad.SM)
  pad.PaddingTop = UDim.new(0, Spacing.Pad.XS)
  pad.PaddingBottom = UDim.new(0, Spacing.Pad.XS)
  pad.Parent = badge

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(1, 0)
  corner.Parent = badge

  return badge
end

return Badge
