--[[
  SuperInstance — Notification (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Motion = require(Design:WaitForChild("motion"))
local Typography = require(Design:WaitForChild("typography"))

local Notification = {}

function Notification.New(parent, config)
  config = config or {}
  local variant = config.variant or "info"
  local theme = Colors.GetTheme()

  local accent = {
    info = Colors.Semantic.Info[500],
    success = Colors.Semantic.Success[500],
    warning = Colors.Semantic.Warning[500],
    danger = Colors.Semantic.Danger[500],
  }[variant]

  local frame = Instance.new("Frame")
  frame.Name = config.name or "SiNotification"
  frame.Parent = parent
  frame.BackgroundColor3 = theme.BgSurface
  frame.BorderSizePixel = 0
  frame.Size = UDim2.new(1, 0, 0, 0)
  frame.AutomaticSize = Enum.AutomaticSize.Y

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, Spacing.Radius.MD)
  corner.Parent = frame

  local stroke = Instance.new("UIStroke")
  stroke.Color = theme.BorderSubtle
  stroke.Thickness = 1
  stroke.Parent = frame

  local leftBar = Instance.new("Frame")
  leftBar.Name = "LeftBar"
  leftBar.Parent = frame
  leftBar.BackgroundColor3 = accent
  leftBar.BorderSizePixel = 0
  leftBar.Size = UDim2.new(0, 4, 1, 0)
  leftBar.Position = UDim2.new(0, 0, 0, 0)

  local content = Instance.new("Frame")
  content.Name = "Content"
  content.Parent = frame
  content.BackgroundTransparency = 1
  content.Size = UDim2.new(1, -16, 0, 0)
  content.Position = UDim2.new(0, 12, 0, 0)
  content.AutomaticSize = Enum.AutomaticSize.Y

  local list = Instance.new("UIListLayout")
  list.Padding = UDim.new(0, Spacing.Gap.XS)
  list.SortOrder = Enum.SortOrder.LayoutOrder
  list.Parent = content

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingRight = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingTop = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingBottom = UDim.new(0, Spacing.Pad.MD)
  pad.Parent = content

  if config.title then
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = content
    title.Text = config.title
    title.TextColor3 = theme.FgPrimary
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 0)
    title.AutomaticSize = Enum.AutomaticSize.Y
    Typography.Apply(title, "H5")
  end

  local message = Instance.new("TextLabel")
  message.Name = "Message"
  message.Parent = content
  message.Text = config.message or ""
  message.TextColor3 = theme.FgSecondary
  message.BackgroundTransparency = 1
  message.Size = UDim2.new(1, 0, 0, 0)
  message.AutomaticSize = Enum.AutomaticSize.Y
  message.TextWrapped = true
  Typography.Apply(message, "BodySm")

  -- Entrance animation
  frame.Position = UDim2.new(0, 16, 0, 0)
  frame.BackgroundTransparency = 1
  local entrance = TweenService:Create(frame, Motion.Tweens.Base, {
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundTransparency = 0,
  })
  entrance:Play()

  return frame
end

return Notification
