--[[
  SuperInstance Design System — Motion (Roblox)
]]

local Motion = {}

--------------------------------------------------------------------------------
-- Easing style mapping (closest Roblox equivalents)
--------------------------------------------------------------------------------
Motion.Easing = {
  Linear = Enum.EasingStyle.Linear,
  In = Enum.EasingStyle.Sine,       -- Roblox has no dedicated "ease-in"
  Out = Enum.EasingStyle.Quart,
  InOut = Enum.EasingStyle.Sine,
  Spring = Enum.EasingStyle.Back,
  Decelerate = Enum.EasingStyle.Quart,
  Emphasized = Enum.EasingStyle.Cubic,
}

Motion.EasingDirection = {
  In = Enum.EasingDirection.In,
  Out = Enum.EasingDirection.Out,
  InOut = Enum.EasingDirection.InOut,
}

--------------------------------------------------------------------------------
-- Duration scale (seconds)
--------------------------------------------------------------------------------
Motion.Duration = {
  Instant = 0,
  Fast = 0.1,
  Base = 0.2,
  Normal = 0.3,
  Slow = 0.5,
  Slower = 0.7,
}

--------------------------------------------------------------------------------
-- Stagger (seconds)
--------------------------------------------------------------------------------
Motion.Stagger = {
  Tight = 0.03,
  Base = 0.05,
  Loose = 0.1,
}

--------------------------------------------------------------------------------
-- Prebuilt TweenInfo tokens
--------------------------------------------------------------------------------
Motion.Tweens = {
  Instant = TweenInfo.new(Motion.Duration.Instant, Motion.Easing.Linear),
  Fast = TweenInfo.new(Motion.Duration.Fast, Motion.Easing.Out, Motion.EasingDirection.Out),
  Base = TweenInfo.new(Motion.Duration.Base, Motion.Easing.Out, Motion.EasingDirection.Out),
  Normal = TweenInfo.new(Motion.Duration.Normal, Motion.Easing.Out, Motion.EasingDirection.Out),
  Slow = TweenInfo.new(Motion.Duration.Slow, Motion.Easing.InOut, Motion.EasingDirection.InOut),
  Slower = TweenInfo.new(Motion.Duration.Slower, Motion.Easing.InOut, Motion.EasingDirection.InOut),
  Spring = TweenInfo.new(Motion.Duration.Normal, Motion.Easing.Spring, Motion.EasingDirection.Out),
  Emphasized = TweenInfo.new(Motion.Duration.Normal, Motion.Easing.Emphasized, Motion.EasingDirection.Out),
}

--------------------------------------------------------------------------------
-- Helper to build custom TweenInfo
--------------------------------------------------------------------------------
function Motion.Build(duration, style, direction)
  style = style or Motion.Easing.Out
  direction = direction or Motion.EasingDirection.Out
  return TweenInfo.new(duration, style, direction)
end

--------------------------------------------------------------------------------
-- Sequential stagger helper
--------------------------------------------------------------------------------
function Motion.StaggerPlay(tweens, stagger)
  stagger = stagger or Motion.Stagger.Base
  for i, tween in ipairs(tweens) do
    task.delay((i - 1) * stagger, function()
      tween:Play()
    end)
  end
end

return Motion
