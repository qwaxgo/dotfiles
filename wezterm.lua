local wezterm = require("wezterm")

return {
	-- Theme
	color_scheme = "MyTheme",

	-- Font
	font = wezterm.font_with_fallback({
		{ family = "Cica", weight = "Regular" },
		{ family = "Cica", weight = "Regular", assume_emoji_presentation = true },
        { family = "Noto Fonts Emoji", weight = "Regular"}
	}),
	font_size = 14.0,

	-- Padding
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 10,
	},

	-- Tab
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,

	-- Misc
	use_ime = true, -- Enable IME
	check_for_updates = false, -- Disable update check
}
