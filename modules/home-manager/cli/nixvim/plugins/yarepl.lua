--- yarepl only activates in Nixvim if this file is available

local yarepl = require("yarepl")
yarepl.setup({
	-- see `:h buflisted`, whether the REPL buffer should be buflisted.
	buflisted = true,
	-- whether the REPL buffer should be a scratch buffer.
	scratch = true,
	-- the filetype of the REPL buffer created by `yarepl`
	ft = "REPL",
	-- How yarepl open the REPL window, can be a string or a lua function.
	-- See below example for how to configure this option
	wincmd = "belowright 15 split",
	-- The available REPL palattes that `yarepl` can create REPL based on.
	-- To disable a built-in meta, set its key to `false`, e.g., `metas = { R = false }`
	metas = {
		aichat = { cmd = "aichat", formatter = yarepl.formatter.bracketed_pasting },
		radian = { cmd = "radian", formatter = yarepl.formatter.bracketed_pasting },
		ipython = { cmd = "ipython", formatter = yarepl.formatter.bracketed_pasting },
		python = { cmd = "python", formatter = yarepl.formatter.trim_empty_lines },
		R = { cmd = "R", formatter = yarepl.formatter.trim_empty_lines },
		bash = { cmd = "bash", formatter = yarepl.formatter.trim_empty_lines },
		zsh = { cmd = "zsh", formatter = yarepl.formatter.bracketed_pasting },
	},
	-- when a REPL process exits, should the window associated with those REPLs closed?
	close_on_exit = true,
	-- whether automatically scroll to the bottom of the REPL window after sending
	-- text? This feature would be helpful if you want to ensure that your view
	-- stays updated with the latest REPL output.
	scroll_to_bottom_after_sending = true,
	-- Format REPL buffer names as #repl_name#n (e.g., #ipython#1) instead of using terminal defaults
	format_repl_buffers_names = true,
	os = {
		-- Some hacks for Windows. macOS and Linux users can simply ignore
		-- them. The default options are recommended for Windows user.
		windows = {
			-- Send a final `\r` to the REPL with delay,
			send_delayed_final_cr = true,
		},
	},
	-- Display the first line as virtual text to indicate the actual
	-- command sent to the REPL.
	source_command_hint = {
		enabled = false,
		hl_group = "Comment",
	},
})
