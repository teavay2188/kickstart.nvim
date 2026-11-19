local u = require 'utils'
local s, i, fmta = u.s, u.i, u.fmta

return {
  s(
    { trig = 'ckt', name = 'CircuitikZ diagram', dscr = 'CircuitikZ environment: options, circuit' },
    fmta(
      [[
\begin{circuitikz}[<>]
  <>
\end{circuitikz}
<>
]],
      { i(1, 'american'), i(2), i(0) }
    )
  ),
}
