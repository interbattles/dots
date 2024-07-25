import { opt, mkOptions } from "lib/option"
import { distro } from "lib/variables"
import { icon } from "lib/utils"
import icons from "lib/icons"

const options = mkOptions(OPTIONS, {
  autotheme: opt(true),
  autotheme_type: opt("scheme-tonal-spot"),

  wallpaper: {
    resolution: opt<import("service/wallpaper").Resolution>(1920),
    market: opt<import("service/wallpaper").Market>("random"),
    source: opt<'bing' | string>(`${Utils.HOME}/walls`),
    speed: opt(30)
  },

  theme: {
    dark: {
      primary: {
        bg: opt("#f5c2e7"),
        fg: opt("#181825"),
      },
      error: {
        bg: opt("#f38ba8"),
        fg: opt("#181825"),
      },
      bg: opt("#1e1e2e"),
      fg: opt("#cdd6f4"),
      widget: opt("#cdd6f4"),
      border: opt("#11111b"),
    },
    light: {
      primary: {
        bg: opt("#426ede"),
        fg: opt("#eeeeee"),
      },
      error: {
        bg: opt("#b13558"),
        fg: opt("#eeeeee"),
      },
      bg: opt("#fffffa"),
      fg: opt("#080808"),
      widget: opt("#080808"),
      border: opt("#080808"),
    },

    opacity: opt(0),
    blur: {
      size: opt(0),
      passes: opt(1)
    },
    scheme: opt<"dark" | "light">("dark"),
    widget: { opacity: opt(94) },
    border: {
      width: opt(2),
      opacity: opt(96),
    },

    shadows: opt(true),
    padding: opt(7),
    spacing: opt(12),
    radius: opt(11),
  },

  transition: opt(200),

  font: {
    size: opt(13),
    name: opt("Ubuntu Nerd Font"),
  },

  bar: {
    flatButtons: opt(true),
    position: opt<"top" | "bottom">("top"),
    corners: opt(50),
    transparent: opt(false),
    layout: {
      start: opt<Array<import("widget/bar/Bar").BarWidget>>([
        "launcher",
        "workspaces",
        "taskbar",
        "expander",
        "messages",
      ]),
      center: opt<Array<import("widget/bar/Bar").BarWidget>>([
        "date",
      ]),
      end: opt<Array<import("widget/bar/Bar").BarWidget>>([
        "media",
        "expander",
        "systray",
        // "colorpicker",
        "screenrecord",
        "system",
        "battery",
        "powermenu",
      ]),
    },
    launcher: {
      icon: {
        colored: opt(true),
        icon: opt(icon(distro.logo, icons.ui.search)),
      },
      label: {
        colored: opt(false),
        label: opt(" Applications"),
      },
      action: opt(() => App.toggleWindow("launcher")),
    },
    date: {
      format: opt("%X - %a. %b. %d"),
      action: opt(() => App.toggleWindow("datemenu")),
    },
    battery: {
      bar: opt<"hidden" | "regular" | "whole">("regular"),
      charging: opt("#00D787"),
      percentage: opt(true),
      blocks: opt(7),
      width: opt(50),
      low: opt(30),
    },
    workspaces: {
      workspaces: opt(7),
    },
    taskbar: {
      iconSize: opt(0),
      monochrome: opt(false),
      exclusive: opt(false),
    },
    messages: {
      action: opt(() => App.toggleWindow("datemenu")),
    },
    systray: {
      ignore: opt([]),
    },
    media: {
      monochrome: opt(true),
      preferred: opt("spotify"),
      direction: opt<"left" | "right">("right"),
      format: opt("{artists} - {title}"),
      length: opt(40),
    },
    powermenu: {
      monochrome: opt(false),
      action: opt(() => App.toggleWindow("powermenu")),
    },
  },

  launcher: {
    width: opt(0),
    margin: opt(80),
    nix: {
      pkgs: opt("nixpkgs/nixos-unstable"),
      max: opt(8),
    },
    sh: {
      max: opt(16),
    },
    apps: {
      iconSize: opt(30),
      max: opt(5),
      favorites: opt([
        [
          "chromium",
          "neovide",
          "wezterm",
          "nemo",
          "spotify",
        ],
      ]),
    },
  },

  overview: {
    scale: opt(9),
    workspaces: opt(7),
    monochromeIcon: opt(false),
  },

  powermenu: {
    sleep: opt("systemctl suspend"),
    reboot: opt("systemctl reboot"),
    logout: opt("pkill Hyprland"),
    shutdown: opt("shutdown now"),
    layout: opt<"line" | "box">("line"),
    labels: opt(true),
  },

  quicksettings: {
    avatar: {
      image: opt(`${Utils.HOME}/.config/avatar`),
      size: opt(60),
    },
    width: opt(380),
    position: opt<"left" | "center" | "right">("right"),
    networkSettings: opt("gtk-launch gnome-control-center"),
    media: {
      monochromeIcon: opt(true),
      coverSize: opt(100),
    },
  },

  datemenu: {
    position: opt<"left" | "center" | "right">("center"),
    weather: {
      interval: opt(60_000),
      unit: opt<"metric" | "imperial" | "standard">("metric"),
      key: opt<string>(
        JSON.parse(Utils.readFile(`${App.configDir}/.weather`) || "{}")?.key || "",
      ),
      cities: opt<Array<number>>(
        JSON.parse(Utils.readFile(`${App.configDir}/.weather`) || "{}")?.cities || [],
      ),
    },
  },

  osd: {
    progress: {
      vertical: opt(true),
      pack: {
        h: opt<"start" | "center" | "end">("end"),
        v: opt<"start" | "center" | "end">("center"),
      },
    },
    microphone: {
      pack: {
        h: opt<"start" | "center" | "end">("center"),
        v: opt<"start" | "center" | "end">("end"),
      },
    },
  },

  notifications: {
    position: opt<Array<"top" | "bottom" | "left" | "right">>(["top", "right"]),
    blacklist: opt(["Spotify"]),
    width: opt(440),
  },

  hyprland: {
    gaps: opt(3),
    inactiveBorder: opt("#282828"),
    gapsWhenOnly: opt(true),
  },
})

globalThis["options"] = options
export default options
