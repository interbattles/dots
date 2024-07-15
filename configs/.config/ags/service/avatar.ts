import { sh } from "lib/utils"

export const AV = `${Utils.HOME}/.config/avatar`

class Avatar extends Service {
  static {
    Service.register(this, {}, {
      "avatar": ["string"],
    })
  }

  async #setAvatar(path: string) {
    await sh(`cp ${path} ${AV}`)
    this.avatar
  }

  readonly set = (path: string) => { this.#setAvatar(path) }
  get avatar() { return AV }

  constructor() {
    super()

    Utils.monitorFile(AV, (file, event) => {
      console.log(file.get_parse_name(), event)
      this.changed("avatar")
    })
  }
}

export default new Avatar
