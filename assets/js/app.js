// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

function formatDuration(seconds) {
  let hours = Math.floor(seconds / 3600)
  let minutes = Math.floor((seconds % 3600) / 60)
  let secs = seconds % 60

  // Left pad the numbers with leading zeros if necessary
  hours = hours.toString().padStart(2, '0')
  minutes = minutes.toString().padStart(2, '0')
  secs = secs.toString().padStart(2, '0')

  return `${hours}:${minutes}:${secs}`
}

Hooks.Countdown = {
  tick() {
    let now = new Date()
    let diff = this.target - now
    let seconds = Math.floor(diff / 1000)

    if (seconds <= 0) {
      this.el.innerHTML = "00:00:00"
      return
    }

    this.el.innerHTML = formatDuration(seconds)

    this.timeout = setTimeout(() => this.tick(), 1000)
  },
  mounted() {
    this.target = new Date(this.el.dataset.target)

    this.tick()
  },
  destroyed() {
    clearTimeout(this.timeout)
  },
  updated() {
    clearTimeout(this.timeout)
    this.mounted()
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken},
  hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

