# CircuitikZ snippets

Add `\usepackage{circuitikz}` to your LaTeX preamble. In a `tex` buffer,
type a trigger, select its completion, and press `Ctrl-y` to expand it.
Use `Tab` / `Shift-Tab` to move forward / backward through the fields.
`Ctrl-Space` opens completion manually.

| Trigger | Inserts |
| --- | --- |
| `ckt` | `circuitikz` environment (options, then diagram contents) |
| `res` | Resistor |
| `cap` | Capacitor |
| `nmos` | Three-terminal NMOS (gate, drain, source) |
| `pmos` | Three-terminal PMOS (gate, drain, source) |
| `comp` | Comparator (`+`/`-` triangle labeled `CMP`) |
| `opamp` | Operational amplifier |
| `vdc` | DC voltage source |
| `vac` | Sinusoidal AC voltage source |

Expand components inside a `circuitikz` environment. The `ckt` snippet defaults
to `american`; you can change that field to `european` for rectangular resistors.

## Placement and rotation

- **Resistor, capacitor, sources:** position → angle → length → name → label.
  Position is the first lead endpoint, such as `0,0` or an existing anchor like
  `M1.D`. The second endpoint is `++(angle:length)`: `0` points right, `90` up,
  `180` left, and `270` down. Length is the distance between the lead endpoints
  in TikZ units (normally cm). Sources default to `90` degrees.
- **MOSFETs, comparator, op-amp:** position → rotation → name → label.
  Position places the node center. Rotation is counterclockwise in degrees
  from the symbol's default orientation; `0`, `90`, `180`, and `270` are useful.

Enter coordinates without parentheses and labels without `$` delimiters.
Give each component a unique name when adding multiple instances. Names and
display labels are separate fields, so labels can also contain values such as
`10\,\mathrm{k}\Omega`.

For example, a resistor starting at `(1,2)` and pointing upward:

```tex
\draw (1,2) to[R, l={$R_1$}, name=R1] ++(90:2);
```

A MOSFET at `(4,2)`, rotated by 90 degrees:

```tex
\draw (4,2) node[nmos, nobulk, rotate=90] (M1) {$M_1$};
```

## Connecting components

Named terminals follow the component when it rotates:

- MOSFET: `(M1.G)`, `(M1.D)`, `(M1.S)`.
- Comparator/op-amp: `(U1.+)`, `(U1.-)`, `(U1.out)`, `(U1.up)`, `(U1.down)`
  (use `CMP1` for the default comparator name).
- Two-terminal components: `(R1.left)`, `(R1.right)` are the symbol's terminals.
  The full lead endpoints are the coordinates in the `\draw` command.

Connect them with ordinary TikZ paths, for example:

```tex
\draw (M1.D) -- (U1.+);
```
