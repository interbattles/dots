import { SimpleToggleButton } from "../ToggleButton"
import Recorder from 'service/screenrecord'
import icons from "lib/icons"

const formatTime = (ms: number) => {
  const seconds = Math.floor(Math.abs(ms / 1000))
  const h = Math.floor(seconds / 3600)
  const m = Math.floor((seconds % 3600) / 60)
  const s = Math.round(seconds % 60)
  const t = [h, m > 9 ? m : h ? '0' + m : m || '0', s > 9 ? s : '0' + s]
    .filter(Boolean)
    .join(':')
  return ms < 0 && seconds ? `-${t}` : t
}

export const RecordingToggle = () => SimpleToggleButton({
  label: Recorder.bind("recording").as((t) => t
    ? formatTime(Recorder.timer)
    : 'Record'),
  connection: [Recorder, () => Recorder.recording],
  toggle: () => {
    Recorder.recording
      ? Recorder.stop()
      : Recorder.start()
  },
  icon: Recorder.bind("recording").as(t => t
    ? icons.recorder.recording
    : icons.recorder.disabled),
})
