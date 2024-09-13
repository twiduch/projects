import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {
  static targets = ["select"];

  async change(event) {
    const selectedStatus = event.target.value
    const projectId = event.target.dataset.projectId

    const data = new FormData();
    data.append("status", selectedStatus)

    try {
      const response = await post(`/projects/${projectId}/status_change`, {
        body: data,
        responseKind: 'turbo-stream'
      });

      if (response.ok) {
        this.showStatusChange()
      } else {
        location.reload()
      }
    } catch (error) {
      console.error('Error:', error)
    }
  }

  updateValue(newValue) {
    this.selectTarget.value = newValue
    this.showStatusChange()
  }

  showStatusChange() {
    const messageElement = document.getElementById('status-message')
    messageElement.classList.remove('hidden')
    setTimeout(() => {
      messageElement.classList.add('hidden')
    }, 2000)

  }
}
