--[[
  SuperInstance — Button (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Motion = require(Design:WaitForChild("motion"))
local Typography = require(Design:WaitForChild("typography"))

local Button = {}

function Button.New(parent, config)
  config = config or {}
  local variant = config.variant or "primary"
  local size = config.size or "md"
  local text = config.text or "Action"

  local theme = Colors.GetTheme()
  local styles = {
    primary = {
      bg = theme.AccentPrimary,
      fg = theme.FgInverted,
      border = nil,
      hover = theme.AccentPrimaryHover,
    },
    secondary = {
      bg = theme.BgSurface,
      fg = theme.FgPrimary,
      border = theme.BorderDefault,
      hover = theme.BgSecondary,
    },
    ghost = {
      bg = theme.BgPrimary,
      fg = theme.FgLink,
      border = nil,
      hover = theme.BgSecondary,
    },
    danger = {
      bg = Colors.Semantic.Danger[500],
      fg = Color3.fromHex("#ffffff"),
      border = nil,
      hover = Colors.Semantic.Danger[700],
    },
  }

  local style = styles[variant]
  local padding = {
    sm = Spacing.PaddingAxis(3, 1),
    md = Spacing.PaddingAxis(4, 2),
    lg = Spacing.PaddingAxis(6, 3),
  }[size]

  local button = Instance.new("TextButton")
  button.Name = config.name or "SiButton"
  button.Parent = parent
  button.AutoButtonColor = false
  button.Text = text
  button.TextColor3 = style.fg
  button.BackgroundColor3 = style.bg
  button.BorderSizePixel = 0
  button.TextSize = (size == "sm" and 12) or (size == "lg" and 16) or 14
  button.Font = Typography.Weight.Semibold
  button.Size = UDim2.new(0, 0, 0, 0)
  button.AutomaticSize = Enum.AutomaticSize.XY

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, Spacing.Radius.MD)
  corner.Parent = button

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, padding.Left)
  pad.PaddingRight = UDim.new(0, padding.Right)
  pad.PaddingTop = UDim.new(0, padding.Top)
  pad.PaddingBottom = UDim.new(0, padding.Bottom)
  pad.Parent = button

  if style.border then
    local stroke = Instance.new("UIStroke")
    stroke.Color = style.border
    stroke.Thickness = 1
    stroke.Parent = button
  end

  -- Hover tween
  local hoverGoal = { BackgroundColor3 = style.hover }
  local hoverTween = TweenService:Create(button, Motion.Tweens.Fast, hoverGoal)
  local outTween = TweenService:Create(button, Motion.Tweens.Fast, { BackgroundColor3 = style.bg })

  button.MouseEnter:Connect(function()
    hoverTween:Play()
  end)
  button.MouseLeave:Connect(function()
    outTween:Play()
  end)

  return button
end

return Button
