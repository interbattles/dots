import options from "options"
import { dependencies, sh } from "lib/utils"

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

const WP = `${Utils.HOME}/.wallpaper`
const Cache = `${Utils.HOME}/Pictures/Wallpapers/Bing`

class Wallpaper extends Service {
  static {
    Service.register(this, {}, {
      "wallpaper": ["string"],
    })
  }

  #blockMonitor = false

  async #wallpaper() {
    if (!dependencies("hyprpaper"))
      return
    await sh([
      "hyprctl", "hyprpaper", "unload", "all",
    ])

    await sh(["killall", "hyprpaper"])
    await sh(["hyprpaper"])
  }

  async #setWallpaper(path: string) {
    this.#blockMonitor = true

    await sh(`cp ${path} ${WP}`)
    await this.#wallpaper()

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

  readonly random = () => { this.#fetchBing() }
  readonly set = (path: string) => { this.#setWallpaper(path) }
  get wallpaper() { return WP }

  constructor() {
    super()

    if (!dependencies("hyprpaper"))
      return this

    // gtk portal
    Utils.monitorFile(WP, async () => {
      if (!this.#blockMonitor)
        await this.#wallpaper()
    })

    sh(["killall", "hyprpaper"])
    sh(["hyprpaper"])
  }
}

export default new Wallpaper
