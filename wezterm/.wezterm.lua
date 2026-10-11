-- ============================================================================
--                  WEZTERM CONFIGURATION (Minimal & Clean)
-- ============================================================================
-- Minimalist style with transparent background and blur.
-- ============================================================================

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ----------------------------------------------------------------------------
-- 1. FONTS AND WINDOW GEOMETRY
-- ----------------------------------------------------------------------------
-- Verified exact font names from macOS system profiler
config.font = wezterm.font_with_fallback({
        "DejaVuSansM Nerd Font",
        "DejaVuSansM Nerd Font Mono",
        "DejaVuSansM Nerd Font Propo",
})
config.font_size = 15

config.initial_cols = 190
config.initial_rows = 65
config.window_decorations = "RESIZE"

-- ----------------------------------------------------------------------------
-- 2. GLASS EFFECT (TRANSPARENCY & BLUR)
-- ----------------------------------------------------------------------------
config.window_background_opacity = 0.6
config.text_background_opacity = 1.0
config.macos_window_background_blur = 10

-- ----------------------------------------------------------------------------
-- 3. WINDOW MANAGEMENT
-- ----------------------------------------------------------------------------
config.enable_tab_bar = false

-- ----------------------------------------------------------------------------
-- 4. COLOR SCHEME: Coolnight
-- ----------------------------------------------------------------------------
config.colors = {
        foreground = "#CBE0F0",
        background = "#011423",
        cursor_bg = "#47FF9C",
        cursor_border = "#47FF9C",
        cursor_fg = "#011423",
        selection_bg = "#033259",
        selection_fg = "#CBE0F0",
        ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
        brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- ----------------------------------------------------------------------------
-- 5. KEYBINDINGS (TMUX-STYLE)
-- ----------------------------------------------------------------------------
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
        -- Pane Splitting (Fixed directional logic)
        {
                key = '"',
                mods = "LEADER",
                action = wezterm.action.SplitPane({ direction = "Down" }),
        },
        {
                key = "|",
                mods = "LEADER",
                action = wezterm.action.SplitPane({ direction = "Right" }),
        },
        -- Double Ctrl+a pass-through to underlying applications
        {
                key = "a",
                mods = "LEADER|CTRL",
                action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
        },
        -- Pane Navigation
        {
                key = "DownArrow",
                mods = "LEADER",
                action = wezterm.action.ActivatePaneDirection("Down"),
        },
        {
                key = "UpArrow",
                mods = "LEADER",
                action = wezterm.action.ActivatePaneDirection("Up"),
        },
        {
                key = "LeftArrow",
                mods = "LEADER",
                action = wezterm.action.ActivatePaneDirection("Left"),
        },
        {
                key = "RightArrow",
                mods = "LEADER",
                action = wezterm.action.ActivatePaneDirection("Right"),
        },
}

return config

