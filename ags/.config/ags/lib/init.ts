import matugen from "./matugen"
import tmux from "./tmux"
import gtk from "./gtk"
import lowBattery from "./battery"
import notifications from "./notifications"

export default function init() {
  try {
    gtk()
    tmux()
    matugen()
    lowBattery()
    notifications()
  } catch (error) {
    logError(error)
  }
}
