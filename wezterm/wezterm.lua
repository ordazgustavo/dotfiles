local wezterm = require("wezterm")

local config = {
	font = wezterm.font({
		family = "SF Mono",
		weight = "DemiBold",
		-- harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
		-- harfbuzz_features = { "liga" },
	}),
	font_size = 17.0,
	line_height = 1.2,
	color_scheme = "Catppuccin Macchiato",
	use_fancy_tab_bar = false,
	-- tab_bar_at_bottom = true,
	default_prog = { "/opt/homebrew/bin/fish", "-l" },
	window_decorations = "RESIZE",
}

return config
