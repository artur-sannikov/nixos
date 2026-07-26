local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s({
            trig = "rcc",
            snippetType = "autosnippet",
            dscr = "Insert R code chunk"
        },
        fmt(
            [[
      ```{r}
      <>
      ```
    ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
}
