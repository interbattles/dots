import avatar from "service/avatar"
import options from "options"
import icons from "lib/icons"

const { size } = options.quicksettings.avatar
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
        opt.setValue(uri!.replace("file://", ""))
      },
    })
  ),
  Widget.Box({ hexpand: true }),
  Widget.Box({
    spacing: 10,
    children: [
      Widget.Button({
        vpack: "center",
        class_name: "reset",
        child: Widget.Icon(icons.ui.refresh),
        on_clicked: () => opt.reset(),
        sensitive: opt.bind().as(v => v !== opt.initial),
      }),
      Widget.Box({
        class_name: "avatar",
        child: Widget.Icon({
          icon: avatar.bind("avatar"),
          size: size.bind("value"),
        }),
      })
    ]
  })
)
