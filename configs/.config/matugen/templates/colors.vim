let alpha = {{custom.alpha}}

<* for name, value in colors *>
let {{name}} = "{{value.default.hex}}"
<* endfor *>
