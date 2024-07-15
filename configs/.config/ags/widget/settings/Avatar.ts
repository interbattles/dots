import avatar, { AV } from "service/avatar"
import options from "options"

const { image, size } = options.quicksettings.avatar
const opt = options.quicksettings.avatar.image

export default () => Widget.Box(
  {
    class_name: "row",
    attribute: { opt },
  },
  Widget.Box(
    { vertical: true, vpack: "center" },
    Widget.Label({
      xalign: 0,
      class_name: "row-title",
      label: 'Avatar',
    }),
    Widget.FileChooserButton({
      on_file_set: ({ uri }) => {
        opt.value = uri!.replace("file://", "")
        avatar.set(opt.value)
      },
    })
  ),
  Widget.Box({ hexpand: true }),
  Widget.Box({
    class_name: "avatar",
    css: Utils.merge([image.bind(), size.bind()], (_img, size) => `
        min-width: ${size}px;
        min-height: ${size}px;
        background-image: url('file://${AV}');
        background-size: cover;
    `),
  })
)
