return {
-- Using a zero-index insert node to exit snippet in equation body
s({trig="eq", dscr=""},
  fmta(
    [[
      \begin{equation}
          <>
      \end{equation}
    ]],
    { i(0) }
  )
),
}
