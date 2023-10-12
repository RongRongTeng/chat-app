import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const messages = document.getElementById("messages");
    this.observer = new MutationObserver(this.resetScroll);
    this.observer.observe(messages, { childList: true });
    this.resetScroll();
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect();
    }
  }
  resetScroll() {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
