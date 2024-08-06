local M = {}

<* for name, value in colors *>
M["{{name}}"] = { 
    h = {{value.default.hue}}, 
    s = {{value.default.saturation}}, 
    l ={{value.default.lightness}} 
}
<* endfor *>

vim.g.colors = M 
