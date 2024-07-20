import options from "options"
import { bash, dependencies, sh } from "lib/utils"
import GLib from "types/@girs/glib-2.0/glib-2.0"

export type Resolution = 1920 | 1366 | 3840
export type Market =
  | "random"
  | "en-US"
  | "ja-JP"
  | "en-AU"
  | "en-GB"
  | "de-DE"
  | "en-NZ"
  | "en-CA"

const WP = `${Utils.HOME}/.config/background`
const Cache = `${Utils.HOME}/Pictures/Wallpapers/Bing`
const { source, speed } = options.wallpaper

class Wallpaper extends Service {
  static {
    Service.register(this, {}, {
      "wallpaper": ["string"],
    })
  }

  #blockMonitor = false

  #wallpaper() {
    if (!dependencies("swww"))
      return

    sh([
      "swww", "img",
      "--transition-type", "none",
      WP,
    ]).then(() => {
      this.changed("wallpaper")
    })
  }

  async #setWallpaper(path: string) {
    this.#blockMonitor = true

    await sh(`cp ${path} ${WP}`)
    this.#wallpaper()

    this.#blockMonitor = false
  }

  async #fetchBing() {
    const res = await Utils.fetch("https://bing.biturl.top/", {
      params: {
        resolution: options.wallpaper.resolution.value,
        format: "json",
        image_format: "jpg",
        index: "random",
        mkt: options.wallpaper.market.value,
      },
    }).then(res => res.text())

    if (!res.startsWith("{"))
      return console.warn("bing api", res)

    const { url } = JSON.parse(res)
    const file = `${Cache}/${url.replace("https://www.bing.com/th?id=", "")}`

    if (dependencies("curl")) {
      Utils.ensureDirectory(Cache)
      await sh(`curl "${url}" --output ${file}`)
      this.#setWallpaper(file)
    }
  }

  #createInterval() {
    console.log('creating new interval')
    return setInterval(this.random, options.wallpaper.speed.value * 1000 * 60)
  }

  readonly regenerateCache = () => {
    console.log("re-running wallpaper daemon")
    this.changed("wallpaper")
  }

  readonly reload = () => {
    console.log("reloading wallpaper file")
    this.#wallpaper()
  }

  readonly random = () => {
    if (source.value === 'bing')
      this.#fetchBing()
    else
      bash(`find ${options.wallpaper.source.value} -type f \\( -name '*.png' -o -name '*.jpg' \\) | shuf -n 1`)
        .then(picked => this.#setWallpaper(picked))
        .catch(e => console.error(e))
  }

  readonly set = (path: string) => { this.#setWallpaper(path) }
  get wallpaper() { return WP }

  constructor() {
    super()

    if (!dependencies("swww"))
      return this

    // gtk portal
    Utils.monitorFile(WP, () => {
      if (!this.#blockMonitor)
        this.#wallpaper()
    })

    bash(`pgrep -x swww-daemon || swww-daemon --format xrgb`)
      .then(this.#wallpaper)
      .catch((e) => console.error(e))

    let interval: GLib.Source | null = options.wallpaper.speed.value > 0
      ? this.#createInterval()
      : null

    speed.connect("changed", () => {
      interval?.destroy()
      console.log('destroyed previous interval')

      speed.value > 0
        ? interval = this.#createInterval()
        : interval = null
    })
  }
}

export default new Wallpaper
