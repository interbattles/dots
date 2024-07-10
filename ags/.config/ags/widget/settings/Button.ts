import { Opt } from "lib/option"
import icons from "lib/icons"
export type ButtonProps<T> = {
  opt: Opt<T>,
  title: string
  label?: string
  note?: string
  onClicked: () => void
}

export default <T>(props: ButtonProps<T>) => Widget.Box(
  {
    attribute: { opt: props.opt },
    class_name: "row",
    tooltip_text: props.note ? `note: ${props.note}` : "",
  },
  Widget.Box(
    { vertical: true, vpack: "center" },
    Widget.Label({
      xalign: 0,
      class_name: "row-title",
      label: props.title,
    }),
    Widget.Label({
      xalign: 0,
      class_name: "id",
      label: props.opt.id,
    }),
  ),
  Widget.Box({ hexpand: true }),
  Widget.Box(
    { vpack: "center" },
    Widget.Button({
      onClicked: props.onClicked,
      child: Widget.Box({
        spacing: 8,
        children: [
          Widget.Label({
            label: props.label,
          }),
          Widget.Icon(icons.ui.refresh)
        ]
      }
      )
    }),
  ),
)
