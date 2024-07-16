import { dependencies, sh } from "lib/utils"

import options from "options"
const opt = options.quicksettings.avatar.image

const AV = `${Utils.HOME}/.config/avatar`

class Avatar extends Service {
  static {
    Service.register(this, {}, {
      "avatar": ["string"],
    })
  }

  async #setAvatar(path: string) {
    if (!dependencies('magick'))
      return

    await sh([
      `magick ${path}`,
      '-trim -gravity center -extent 1:1',
      '( +clone -threshold 101% -fill white -draw "circle %[fx:int(w/2)],%[fx:int(h/2)] %[fx:int(w/2)],%[fx:int(h)]" ) -channel-fx "| gray=>alpha"',
      `PNG:${AV}`
    ].join(' '))
    this.changed("avatar")
  }

  get avatar() { 
    if(!Utils.readFile(AV) || opt.value === opt.initial)
      return 'avatar-default'
    return AV 
  }

  constructor() {
    super()

    opt.connect("changed", (opt) => this.#setAvatar(opt.value))
  }
}

export default new Avatar
