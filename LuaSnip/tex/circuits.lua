local u = require 'utils'
local s, t, i, fmta = u.s, u.t, u.i, u.fmta

-- Two-terminal components: position, angle, lead-to-lead length, name, label.
-- The polar endpoint rotates the component together with its leads.
local function bipole(trig, name, kind, id, label, angle)
  return s(
    { trig = trig, name = name, dscr = name .. ': position, angle, length, name, label' },
    fmta([[\draw (<>) to[<>, l={$<>$}, name=<>] ++(<>:<>);<>]], {
      i(1, '0,0'),
      t(kind),
      i(5, label),
      i(4, id),
      i(2, angle or '0'),
      i(3, '2'),
      i(0),
    })
  )
end

-- Node components: position, rotation, name, label.
local function component(trig, name, kind, id, label)
  return s(
    { trig = trig, name = name, dscr = name .. ': position, rotation, name, label' },
    fmta([[\draw (<>) node[<>, rotate=<>] (<>) {$<>$};<>]], {
      i(1, '0,0'),
      t(kind),
      i(2, '0'),
      i(3, id),
      i(4, label),
      i(0),
    })
  )
end

return {
  bipole('res', 'Resistor', 'R', 'R1', 'R_1'),
  bipole('cap', 'Capacitor', 'C', 'C1', 'C_1'),
  component('nmos', 'NMOS (3 terminals)', 'nmos, nobulk', 'M1', 'M_1'),
  component('pmos', 'PMOS (3 terminals)', 'pmos, nobulk', 'M2', 'M_2'),
  -- Comparators use the conventional +/- triangle, with a distinguishing label.
  component('comp', 'Comparator', 'op amp', 'CMP1', [[\mathrm{CMP}_1]]),
  component('opamp', 'Operational amplifier', 'op amp', 'U1', 'U_1'),
  bipole('vdc', 'DC voltage source', 'dcvsource', 'VDC1', [[V_{\mathrm{DC}}]], '90'),
  bipole('vac', 'AC voltage source', 'sV', 'VAC1', [[V_{\mathrm{AC}}]], '90'),
}
