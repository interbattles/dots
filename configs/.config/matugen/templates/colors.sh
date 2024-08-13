#/usr/bin/env sh
alpha="{{custom.alpha}}"
image="{{image}}"

<* for name, value in colors *>
{{name}}="{{value.default.hex}}"
<* endfor *>
