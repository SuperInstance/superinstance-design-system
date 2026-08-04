--[[
  SuperInstance — Input (Roblox)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")
local Colors = require(Design:WaitForChild("colors"))
local Spacing = require(Design:WaitForChild("spacing"))
local Typography = require(Design:WaitForChild("typography"))

local Input = {}

function Input.New(parent, config)
  config = config or {}
  local theme = Colors.GetTheme()

  local container = Instance.new("Frame")
  container.Name = config.name or "SiInput"
  container.Parent = parent
  container.BackgroundTransparency = 1
  container.Size = UDim2.new(1, 0, 0, 0)
  container.AutomaticSize = Enum.AutomaticSize.Y

  local list = Instance.new("UIListLayout")
  list.Padding = UDim.new(0, Spacing.Gap.XS)
  list.SortOrder = Enum.SortOrder.LayoutOrder
  list.Parent = container

  if config.label then
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Parent = container
    label.Text = config.label
    label.TextColor3 = theme.FgSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 0)
    label.AutomaticSize = Enum.AutomaticSize.Y
    Typography.Apply(label, "Label")
    label.LayoutOrder = 1
  end

  local box = Instance.new("TextBox")
  box.Name = "Box"
  box.Parent = container
  box.Text = config.text or ""
  box.PlaceholderText = config.placeholder or ""
  box.TextColor3 = theme.FgPrimary
  box.BackgroundColor3 = theme.BgSurface
  box.BorderSizePixel = 0
  box.ClearTextOnFocus = false
  box.Size = UDim2.new(1, 0, 0, 40)
  box.TextXAlignment = Enum.TextXAlignment.Left
  box.TextYAlignment = Enum.TextYAlignment.Center
  Typography.Apply(box, "Body")
  box.LayoutOrder = 2

  local pad = Instance.new("UIPadding")
  pad.PaddingLeft = UDim.new(0, Spacing.Pad.MD)
  pad.PaddingRight = UDim.new(0, Spacing.Pad.MD)
  pad.Parent = box

  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, Spacing.Radius.MD)
  corner.Parent = box

  local stroke = Instance.new("UIStroke")
  stroke.Color = theme.BorderDefault
  stroke.Thickness = 1
  stroke.Parent = box

  if config.error then
    stroke.Color = Colors.Semantic.Danger[500]
  end

  box.Focused:Connect(function()
    stroke.Color = config.error and Colors.Semantic.Danger[500] or theme.AccentPrimary
  end)
  box.FocusLost:Connect(function()
    stroke.Color = config.error and Colors.Semantic.Danger[500] or theme.BorderDefault
  end)

  if config.hint then
    local hint = Instance.new("TextLabel")
    hint.Name = "Hint"
    hint.Parent = container
    hint.Text = config.hint
    hint.TextColor3 = theme.FgTertiary
    hint.BackgroundTransparency = 1
    hint.Size = UDim2.new(1, 0, 0, 0)
    hint.AutomaticSize = Enum.AutomaticSize.Y
    Typography.Apply(hint, "BodySm")
    hint.LayoutOrder = 3
  end

  return container, box
end

return Input
