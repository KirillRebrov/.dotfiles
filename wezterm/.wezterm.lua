-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- MesloLGS Nerd Font Mono (1)
-- DejaVuSansM Nerd Font Mono (2)
config.font = wezterm.font("DejaVuSansM Nerd Font")
wezterm.font("DejaVuSansM Nerd Font", { weight = "Bold", italic = true })
config.font_size = 15

-- ??? config.default_prog = { 'zellij' } continue.

config.enable_tab_bar = false

-- config.default_cursor_style = "BlinkingBlock"
-- config.cursor_blink_rate = 450
-- config.animation_fps = 1
-- config.cursor_blink_ease_in = "Linear"
-- config.cursor_blink_ease_out = "Linear"

config.initial_cols = 190
config.initial_rows = 65
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.6
config.text_background_opacity = 1
config.macos_window_background_blur = 10

-- my coolnight colorscheme:

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

-- PowerLine??

-- If you're using emacs you probably wanna choose a different leader here,
-- since we're gonna be making it a bit harder to CTRL + A for jumping to
-- the start of a line
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- ... add these new entries to your config.keys table
	{
		-- I'm used to tmux bindings, so am using the quotes (") key to
		-- split horizontally, and the percent (%) key to split vertically.
		key = '"',
		-- Note that instead of a key modifier mapped to a key on your keyboard
		-- like CTRL or ALT, we can use the LEADER modifier instead.
		-- This means that this binding will be invoked when you press the leader
		-- (CTRL + A), quickly followed by quotes (").
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- ... add these new entries to your config.keys table
	{
		key = "a",
		-- When we're in leader mode _and_ CTRL + A is pressed...
		mods = "LEADER|CTRL",
		-- Actually send CTRL + A key to the terminal
		action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }),
	},
	-- ... add these new entries to your config.keys table
	{
		-- I like to use vim direction keybindings, but feel free to replace
		-- with directional arrows instead.
		key = "DownArrow", -- or j
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "UpArrow", -- or k
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "LeftArrow", -- or h
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow", -- or l
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
}

-- and finally, return the configuration to wezterm
return config
