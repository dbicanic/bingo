import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.addEventListener("turbo:before-stream-render", this.onStreamRender.bind(this))
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.onStreamRender.bind(this))
  }

  onStreamRender(event) {
    const stream = event.detail.newStream
    if (stream.target === "drawn-ball") {
      event.detail.render = async (streamElement) => {
        await streamElement.performAction()
        const ball = document.querySelector("#drawn-ball .rounded-full")
        if (ball) {
          ball.classList.add("scale-0")
          ball.style.transition = "transform 0.15s ease-in"
          requestAnimationFrame(() => {
            ball.classList.remove("scale-0")
            ball.style.transition = "transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1)"
            ball.style.transform = "scale(1)"
          })
        }
      }
    }
  }
}
