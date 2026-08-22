# SuperInstance Design System

The single source of truth for visual identity across all SuperInstance projects:
**activelog.ai**, **lucineer.com**, **fishinglog.ai**, **activeledger.ai**, and the
SuperInstance game.

This repository ships both **web (CSS)** and **Roblox (Lua)** implementations of
the same maritime-engineering design language.

<p align="center">
  <img src="assets/images/hero.jpg" width="700" alt="The chart-room where the fleet's visual language is drafted — one careful mark at a time, by lamplight">
</p>

---

## Table of contents

- [Design principles](#design-principles)
- [Typography](#typography)
- [Color palette](#color-palette)
- [Spacing](#spacing)
- [Motion](#motion)
- [Components](#components)
- [Voice samples](#voice-samples)
- [Usage](#usage)
- [Roblox setup](#roblox-setup)
- [License](#license)

---

## Design principles

1. **Harbor meets engineering.** Warm dock wood and lantern amber balance cold
   deep-water blues and greys. The result feels seaworthy and precise.
2. **Clarity over decoration.** Every token exists to reduce cognitive load for
   operators, players, and readers.
3. **One system, two runtimes.** Web and Roblox share the same scale, names, and
   semantics even when the underlying tech differs.
4. **Motion with purpose.** Transitions guide attention; they never obstruct it.

---

## Typography

### Typefaces

| Role | Web | Roblox |
|------|-----|--------|
| Display / hero | Inter Black | GothamBlack |
| Headings / UI | Inter | Gotham |
| Body | Inter | Gotham |
| Long-form / lore | Merriweather | Garamond |
| Code / data | IBM Plex Mono | Code |

Inter was chosen because it reads cleanly at small sizes on dashboards and
engineering docs. Merriweather adds journal-like warmth for harbor logs and
dialogue. IBM Plex Mono keeps telemetry and code tables scannable.

### Type scale

| Token | Web | Roblox | Usage |
|-------|-----|--------|-------|
| `XS` | `0.75rem` (12px) | `12` | Captions, timestamps |
| `SM` | `0.875rem` (14px) | `14` | Body small, code |
| `Base` | `1rem` (16px) | `16` | Default body |
| `LG` | `1.125rem` (18px) | `18` | Lead paragraphs |
| `XL` | `1.25rem` (20px) | `20` | H5, card titles |
| `2XL` | `1.5rem` (24px) | `24` | H4 |
| `3XL` | `1.875rem` (30px) | `30` | H3 |
| `4XL` | `2.25rem` (36px) | `36` | H2 |
| `5XL` | `3rem` (48px) | `48` | H1 |
| `6XL` | `3.75rem` (60px) | `60` | Display / hero |

### Weight & leading

Weights: `400` / `500` / `600` / `700` / `800` (web); `Gotham`, `GothamMedium`,
`GothamSemibold`, `GothamBold`, `GothamBlack` (Roblox).

Line heights:

- `None` = `1` — large display
- `Tight` = `1.25` — headings
- `Snug` = `1.375` — subheadings
- `Normal` = `1.5` — UI labels
- `Relaxed` = `1.625` — body
- `Loose` = `2` — long-form article

---

## Color palette

### Foundations

```
Harbor  (neutrals)   50 → 900   cool greys for surfaces and text
Water   (blues)      50 → 900   primary actions, links, info
Wood    (browns)     50 → 900   secondary accents, warmth
Amber   (oranges)    50 → 900   warnings, lantern highlights
Foam    (teals)      50 → 900   success, data highlights
Rust    (oranges)    50 → 900   danger, alerts
```

### Semantic colors

| Role | Base | Light surface | Dark text |
|------|------|---------------|-----------|
| Success | Foam 500 | Foam 100 | Foam 900 |
| Warning | Amber 500 | Amber 100 | Amber 900 |
| Danger | Rust 500 | Rust 100 | Rust 900 |
| Info | Water 500 | Water 100 | Water 900 |

### Theme tokens

Both CSS and Lua expose `BgPrimary`, `BgSecondary`, `BgSurface`, `FgPrimary`,
`FgSecondary`, `BorderDefault`, `AccentPrimary`, etc. CSS responds to
`prefers-color-scheme` and supports `.si-theme-dark`. Lua uses
`Colors.SetTheme("Dark")`.

---

## Spacing

Base unit: **4px**.

| Token | Pixels |
|-------|--------|
| `1` | 4px |
| `2` | 8px |
| `3` | 12px |
| `4` | 16px |
| `5` | 20px |
| `6` | 24px |
| `8` | 32px |
| `10` | 40px |
| `12` | 48px |
| `16` | 64px |
| `20` | 80px |
| `24` | 96px |
| `32` | 128px |

Web uses CSS custom properties. Roblox uses numeric values plus `UDim2`
helpers.

---

## Motion

### Easing

| Name | CSS | Roblox style |
|------|-----|--------------|
| Linear | `linear` | `Linear` |
| Ease-out | `cubic-bezier(0, 0, 0.2, 1)` | `Quart.Out` |
| Ease-in-out | `cubic-bezier(0.4, 0, 0.2, 1)` | `Sine.InOut` |
| Spring | `cubic-bezier(0.34, 1.56, 0.64, 1)` | `Back.Out` |
| Emphasized | `cubic-bezier(0.2, 0, 0, 1)` | `Cubic.Out` |

### Duration scale

| Token | CSS | Roblox |
|-------|-----|--------|
| Instant | `0ms` | `0s` |
| Fast | `100ms` | `0.1s` |
| Base | `200ms` | `0.2s` |
| Normal | `300ms` | `0.3s` |
| Slow | `500ms` | `0.5s` |
| Slower | `700ms` | `0.7s` |

### Stagger

- Tight: `30ms`
- Base: `50ms`
- Loose: `100ms`

---

## Components

### Button

```html
<!-- Web -->
<button class="si-button">Primary</button>
<button class="si-button si-button-secondary">Secondary</button>
<button class="si-button si-button-ghost">Ghost</button>
<button class="si-button si-button-danger">Danger</button>
```

```lua
-- Roblox
local Button = require(SuperInstanceDesign.components.button)
Button.New(parent, {
  text = "Cast Off",
  variant = "primary", -- primary | secondary | ghost | danger
  size = "md",         -- sm | md | lg
})
```

### Card

```html
<!-- Web -->
<article class="si-card si-card-hoverable">
  <header class="si-card-header">
    <h3 class="si-card-title">Vessel telemetry</h3>
    <span class="si-badge si-badge-info">Live</span>
  </header>
  <p class="si-card-body">Heading 270°, speed 12.4 kt, depth 42 m.</p>
  <footer class="si-card-footer">
    <button class="si-button si-button-ghost">Details</button>
    <button class="si-button">Acknowledge</button>
  </footer>
</article>
```

```lua
-- Roblox
local Card = require(SuperInstanceDesign.components.card)
Card.New(parent, {
  title = "Vessel telemetry",
  subtitle = "Live feed",
  body = "Heading 270°, speed 12.4 kt, depth 42 m.",
})
```

### Input

```html
<!-- Web -->
<label class="si-input-label" for="callsign">Callsign</label>
<input id="callsign" class="si-input" placeholder="SI-709" />
<span class="si-input-hint">Used for harbor check-in.</span>
```

```lua
-- Roblox
local Input = require(SuperInstanceDesign.components.input)
local container, box = Input.New(parent, {
  label = "Callsign",
  placeholder = "SI-709",
  hint = "Used for harbor check-in.",
})
```

### Badge

```html
<!-- Web -->
<span class="si-badge si-badge-success">Docked</span>
<span class="si-badge si-badge-warning">Fog advisory</span>
```

```lua
-- Roblox
local Badge = require(SuperInstanceDesign.components.badge)
Badge.New(parent, { text = "Docked", variant = "success" })
```

### Notification

```html
<!-- Web -->
<div class="si-notification si-notification-warning">
  <div class="si-notification-content">
    <strong class="si-notification-title">Fog advisory</strong>
    <p class="si-notification-message">Visibility below 1 km until 0600.</p>
  </div>
</div>
```

```lua
-- Roblox
local Notification = require(SuperInstanceDesign.components.notification)
Notification.New(parent, {
  variant = "warning",
  title = "Fog advisory",
  message = "Visibility below 1 km until 0600.",
})
```

### HUD element

```html
<!-- Web -->
<div class="si-hud">
  <span class="si-hud-label">Depth</span>
  <span class="si-hud-value">42 m</span>
</div>
```

```lua
-- Roblox
local Hud = require(SuperInstanceDesign.components.hud)
Hud.New(parent, {
  label = "Depth",
  value = "42 m",
  critical = false,
})
```

---

## Voice samples

### Headlines

> # Fleet telemetry at harbor scale

`.si-text-h1` — bold, tight leading, authoritative.

### Body

> The marina control tower processes arrivals, departures, and berth assignments
> in real time.

`.si-text-body` — relaxed line height for readability.

### Code

```lua
local heading = 270 -- degrees true
local speedKts = 12.4
```

`.si-text-code` — IBM Plex Mono / Roblox `Code`.

### Data table

| Vessel | Speed | Depth | Status |
|--------|-------|-------|--------|
| SI-709 | 12.4 kt | 42 m | `DOCKED` |

`.si-text-data` — tabular numerals, wide tracking.

### Dialogue

> “Hold steady on the approach. The fog’s lifting.”

`.si-text-dialogue` — Merriweather / Garamond, italic, warm.

---

## Usage

### Web

```css
@import url('https://superinstance-design-system.pages.dev/src/colors.css');
@import url('https://superinstance-design-system.pages.dev/src/typography.css');
@import url('https://superinstance-design-system.pages.dev/src/spacing.css');
@import url('https://superinstance-design-system.pages.dev/src/motion.css');
@import url('https://superinstance-design-system.pages.dev/src/components/button.css');
```

Or copy the files into your project and import them locally.

### Roblox

Place the `src/` contents under `ReplicatedStorage.SuperInstanceDesign` and
require the modules:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Design = ReplicatedStorage:WaitForChild("SuperInstanceDesign")

local Colors = require(Design.colors)
local Typography = require(Design.typography)
local Spacing = require(Design.spacing)
local Motion = require(Design.motion)
local Button = require(Design.components.button)
```

---

## Roblox setup

Recommended Explorer layout:

```
ReplicatedStorage
└── SuperInstanceDesign
    ├── colors
    ├── typography
    ├── spacing
    ├── motion
    └── components
        ├── button
        ├── card
        ├── input
        ├── badge
        ├── notification
        └── hud
```

Modules expect this layout to resolve cross-dependencies.

---

## License

MIT — see [LICENSE](./LICENSE).
