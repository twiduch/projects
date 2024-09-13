import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

export default class extends Controller {

  async change(e) {
    const user_id = e.target.selectedOptions[0].value

    await post('/sessions', {
      body: JSON.stringify(
        {
          user_id: user_id
        })
    })

    location.reload()
  }
}
