import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["checkbox", "dialog"]
    checked = false

    open() {
        this.dialogTarget.showModal()
        this.checked = false
    }

    close() {
        this.checkboxTarget.checked = true
        this.checked = true
        this.dialogTarget.close()
    }

    toggleCheckbox() {
        if (this.checked) {
            this.checkboxTarget.checked = false
            this.checked = false
        } else {
            this.open()
        }
    }
}
