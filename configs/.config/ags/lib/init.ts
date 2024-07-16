import matugen from "./matugen"
// import pywal from "./pywal"
import hyprland from "./hyprland"
// import tmux from "./tmux"
import gtk from "./gtk"
import lowBattery from "./battery"
import notifications from "./notifications"

export default function init() {
  try {
    gtk()
    // tmux()
    matugen()
    // pywal()
    lowBattery()
    notifications()
    hyprland()
  } catch (error) {
    logError(error)
  }
}
