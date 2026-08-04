--[[
  SuperInstance — Card (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Typography = require(Design:WaitForChild("typography"))

local Card = {}

function Card.New(parent, config)
  config = config or {}
  local theme = Colors.GetTheme()

  local card = Instance.new("Frame")
  card.Name = config.name or "SiCard"
  card.Parent = parent
  card.BackgroundColor3 = theme.BgSurface
  card.BorderSizePixel = 0
  card.Size = config.size or UDim2.new(1, 0, 0, 0)
  card.AutomaticSize = Enum.AutomaticSize.Y

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, Spacing.Radius.LG)
  corner.Parent = card

  local stroke = Instance.new("UIStroke")
  stroke.Color = theme.BorderSubtle
  stroke.Thickness = 1
  stroke.Parent = card

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, Spacing.Pad.LG)
  pad.PaddingRight = UDim.new(0, Spacing.Pad.LG)
  pad.PaddingTop = UDim.new(0, Spacing.Pad.LG)
  pad.PaddingBottom = UDim.new(0, Spacing.Pad.LG)
  pad.Parent = card

  local list = Instance.new("UIListLayout")
  list.Padding = UDim.new(0, Spacing.Gap.MD)
  list.SortOrder = Enum.SortOrder.LayoutOrder
  list.Parent = card

  if config.title then
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = card
    title.Text = config.title
    title.TextColor3 = theme.FgPrimary
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 0)
    title.AutomaticSize = Enum.AutomaticSize.Y
    Typography.Apply(title, "H5")
    title.LayoutOrder = 1
  end

  if config.subtitle then
    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Parent = card
    subtitle.Text = config.subtitle
    subtitle.TextColor3 = theme.FgSecondary
    subtitle.BackgroundTransparency = 1
    subtitle.Size = UDim2.new(1, 0, 0, 0)
    subtitle.AutomaticSize = Enum.AutomaticSize.Y
    Typography.Apply(subtitle, "BodySm")
    subtitle.LayoutOrder = 2
  end

  if config.body then
    local body = Instance.new("TextLabel")
    body.Name = "Body"
    body.Parent = card
    body.Text = config.body
    body.TextColor3 = theme.FgPrimary
    body.BackgroundTransparency = 1
    body.Size = UDim2.new(1, 0, 0, 0)
    body.AutomaticSize = Enum.AutomaticSize.Y
    body.TextWrapped = true
    Typography.Apply(body, "Body")
    body.LayoutOrder = 3
  end

  return card
end

return Card
