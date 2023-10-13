import { Controller } from "@hotwired/stimulus";
import { useIntersection } from "stimulus-use";

export default class Autoclick extends Controller {
  options = {
    threshold: 0
  };

  static messagesContainer;
  static topMessage;
  static throttling = false;
  static previousTimestamp = 0;

  connect() {
    useIntersection(this, this.options);
  }

  appear(entry) {
    if (!Autoclick.throttling) {
      Autoclick.throttling = true;

      Autoclick.messagesContainer = document.getElementById("messages-container");
      Autoclick.topMessage = Autoclick.messagesContainer.children[0];

      const click = this.throttle(() => { this.element.click(); }, 300);
      click()

      setTimeout(() => {
        Autoclick.topMessage.scrollIntoView({
          behavior: "auto",
          block: "end",
        });
        Autoclick.throttling = false;
      }, 250);
    }
  }

  throttle(func, wait) {
    let timer = null;
    let throttlefunc = () => {
      func();

      Autoclick.previousTimestamp = Date.now();
      timer = null;
    };

    const now = Date.now();
    const remaining = wait - (now - Autoclick.previousTimestamp);

    return function() {
      if (remaining <= 0 || remaining > wait) {
        if (timer) {
          clearTimeout(timer);
        }
        throttlefunc();
      } else if (!timer) {
        timer = setTimeout(throttlefunc, remaining);
      }
    }
  }
}
