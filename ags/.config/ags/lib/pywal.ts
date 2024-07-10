import GLib from "gi://GLib?version=2.0"
import wallpaper from "service/wallpaper"
import options from "options"
import { sh, dependencies } from "./utils"

export default function init() {
  wallpaper.connect("changed", () => pywal())
  options.autotheme.connect("changed", () => pywal())
}

function animate(...setters: Array<() => void>) {
  const delay = options.transition.value / 2
  setters.forEach((fn, i) => Utils.timeout(delay * i, fn))
}

export async function pywal(
  arg = wallpaper.wallpaper,
) {
  if (!options.autotheme.value || !dependencies("wal"))
    return

  console.log("regenerating pywal cache")

  await sh(`wal -s -t -i ${arg} --backend ${options.autotheme_backend} -a ${options.theme.widget.opacity.value} ${options.theme.scheme.value === "dark" ? "" : "-l"}`.trim())
  const c: PyWal = JSON.parse(Utils.readFile(`${GLib.get_user_cache_dir()}/wal/colors.json`))
  const { colors, special } = c

  const { dark, light } = options.theme

  animate(
    () => {
      dark.bg.value = colors.color0
      light.bg.value = colors.color0
    },
    () => {
      dark.widget.value = colors.color8
      light.widget.value = colors.color8
    },
    () => {
      dark.fg.value = special.foreground
      light.fg.value = special.foreground
    },
    () => {
      dark.border.value = colors.color2
      light.border.value = colors.color2
    },
    () => {
      dark.primary.fg.value = special.foreground
      light.primary.fg.value = special.foreground
    },
    () => {
      dark.primary.bg.value = colors.color2
      light.primary.bg.value = colors.color2
      options.bar.battery.charging.value = colors.color2
    },
    () => {
      dark.error.fg.value = special.foreground
      light.error.fg.value = special.foreground
    },
    () => {
      dark.error.bg.value = colors.color1
      light.error.bg.value = colors.color1
    },
  )
}

type PyWal = {
  wallpaper: string
  alpha: string
  special: {
    background: string
    foreground: string
    cursor: string
  },
  colors: {
    color0: string
    color1: string
    color2: string
    color3: string
    color4: string
    color5: string
    color6: string
    color7: string
    color8: string
    color9: string
    color10: string
    color11: string
    color12: string
    color13: string
    color14: string
    color15: string
  }
}
