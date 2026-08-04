--[[
  SuperInstance — HUD Element (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Motion = require(Design:WaitForChild("motion"))
local Typography = require(Design:WaitForChild("typography"))

local Hud = {}

function Hud.New(parent, config)
  config = config or {}
  local critical = config.critical or false
  local theme = Colors.GetTheme()

  local frame = Instance.new("Frame")
  frame.Name = config.name or "SiHud"
  frame.Parent = parent
  frame.BackgroundColor3 = theme.BgOverlay
  frame.BackgroundTransparency = 0.28
  frame.BorderSizePixel = 0
  frame.Size = UDim2.new(0, 0, 0, 0)
  frame.AutomaticSize = Enum.AutomaticSize.XY

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, Spacing.Radius.MD)
  corner.Parent = frame

  local stroke = Instance.new("UIStroke")
  stroke.Color = critical and Colors.Semantic.Danger[500] or theme.BorderStrong
  stroke.Thickness = 1
  stroke.Transparency = 0.2
  stroke.Parent = frame

  local list = Instance.new("UIListLayout")
  list.Padding = UDim.new(0, Spacing.Gap.SM)
  list.FillDirection = Enum.FillDirection.Horizontal
  list.VerticalAlignment = Enum.VerticalAlignment.Center
  list.SortOrder = Enum.SortOrder.LayoutOrder
  list.Parent = frame

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingRight = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingTop = UDim.new(0, Spacing.Pad.SM)
  pad.PaddingBottom = UDim.new(0, Spacing.Pad.SM)
  pad.Parent = frame

  if config.label then
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = frame
    label.Text = config.label
    label.TextColor3 = theme.FgTertiary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0, 0, 0, 0)
    label.AutomaticSize = Enum.AutomaticSize.XY
    Typography.Apply(label, "Label")
  end

  local value = Instance.new("TextLabel")
  value.Name = "Value"
  value.Parent = frame
  value.Text = config.value or "--"
  value.TextColor3 = critical and Colors.Semantic.Danger[300] or theme.AccentFoam
  value.BackgroundTransparency = 1
  value.Size = UDim2.new(0, 0, 0, 0)
  value.AutomaticSize = Enum.AutomaticSize.XY
  Typography.Apply(value, "Data")

  if critical then
    local pulse = TweenService:Create(stroke, Motion.Tweens.Slow, {
      Transparency = 0.6,
    })
    pulse.Reverses = true
    pulse.RepeatCount = -1
    pulse:Play()
  end

  return frame, value
end

return Hud
