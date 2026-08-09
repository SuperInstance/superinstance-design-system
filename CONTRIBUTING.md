# Contributing to the SuperInstance Design System

## What This Is

The SuperInstance Design System is the single source of truth for visual identity across all SuperInstance projects: activelog.ai, lucineer.com, fishinglog.ai, activeledger.ai, and the SuperInstance game. It ships both web (CSS) and Roblox (Lua) implementations of the same maritime-engineering design language.

## Development Setup

No build step. The design system is pure tokens (CSS custom properties + Lua tables). Clone and go.

```bash
git clone git@github.com:SuperInstance/superinstance-design-system.git
cd superinstance-design-system
```

### Prerequisites

- **Web:** a browser or bundler that supports CSS custom properties (all modern browsers)
- **Roblox:** Roblox Studio with Argon sync (or manual file copy)
- **Tests:** Lua 5.1 for running token validation tests

## Running Tests

```bash
# Run all Lua token tests
lua5.1 tests/test_design_tokens.lua

# Typography tests
lua5.1 tests/test_typography.lua

# Or run all tests at once
for f in tests/*.lua; do lua5.1 "$f" || break; done
```

Tests validate that Lua token tables match their CSS counterparts — the two implementations must stay in sync.

## Project Structure

```
superinstance-design-system/
├── src/
│   ├── colors.css         # CSS custom properties for the color palette
│   ├── colors.lua         # Roblox Lua table mirroring colors.css
│   ├── typography.css     # Type scale, font families, weights
│   ├── typography.lua     # Roblox Lua table mirroring typography.css
│   ├── spacing.css        # Spacing scale
│   ├── spacing.lua        # Roblox Lua table mirroring spacing.css
│   ├── motion.css         # Transition and animation tokens
│   ├── motion.lua         # Roblox Lua table mirroring motion.css
│   └── components/        # Component implementations (CSS + Lua pairs)
│       ├── badge.{css,lua}
│       ├── button.{css,lua}
│       ├── card.{css,lua}
│       ├── hud.{css,lua}
│       ├── input.{css,lua}
│       └── notification.{css,lua}
├── tests/
│   ├── test_design_tokens.lua
│   └── test_typography.lua
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## Code Style

- **One system, two runtimes.** Every token has both a `.css` and a `.lua` implementation. They must stay in sync. If you change one, change the other.
- **Token names match across runtimes.** `--si-color-deep-water` in CSS corresponds to `Colors.DeepWater` in Lua. Follow the naming convention.
- **Maritime-engineering design language.** Token names reference nautical and engineering concepts (deep-water, harbor, lantern-amber). Respect the vocabulary.
- **No framework dependencies.** CSS files are pure custom properties. Lua files are pure tables. No preprocessors, no runtime libraries.
- **Components come in pairs.** Every component has a `.css` and `.lua` file implementing the same visual spec.
- **Commits:** conventional commits (`feat:`, `fix:`, `test:`, `docs:`, `chore:`, `refactor:`)

## Design Principles

1. **Harbor meets engineering.** Warm dock wood and lantern amber balance cold deep-water blues and greys.
2. **Clarity over decoration.** Every token exists to reduce cognitive load.
3. **One system, two runtimes.** Web and Roblox share the same scale, names, and semantics.
4. **Motion with purpose.** Transitions guide attention; they never obstruct it.

## Pull Request Checklist

- [ ] Lua tests pass (`lua5.1 tests/test_design_tokens.lua`)
- [ ] CSS and Lua tokens are in sync (both changed if applicable)
- [ ] Token names follow maritime-engineering vocabulary
- [ ] No framework dependencies introduced
- [ ] New components have both `.css` and `.lua` files
- [ ] README updated if new tokens or components are added
- [ ] No secrets or credentials committed
- [ ] Commit messages follow conventional commits

## Fleet Context

This design system is the visual foundation of the SuperInstance fleet. Every user-facing surface — websites, game UIs, dashboards, tools — should use these tokens. Consistency across the fleet depends on this being the single source of truth.

Projects using this system:
- **activelog.ai** — activity logging platform
- **lucineer.com** — build agent interface
- **fishinglog.ai** — fishing log application
- **activeledger.ai** — financial ledger platform
- **SuperInstance game** (Roblox) — the game world

Related fleet components:
- `lucineer` — the build agent that constructs Roblox experiences using these design tokens
- All web properties reference these CSS tokens directly or via npm package
