local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		{ trig = "let", dscr = "Let in expression" },
		fmt(
			[[
      let
        <>
      in <>
    ]],
			{ i(1), i(0) },
			{ delimiters = "<>" }
		)
	),
}
