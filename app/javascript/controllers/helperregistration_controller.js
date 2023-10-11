import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["checkbox"]

    enable() {
        this.element.querySelector('.helper-registration__inputs')
            .classList.remove('helper-registration__inputs--disabled')
    }

    disable() {
        this.element.querySelector('.helper-registration__inputs')
            .classList.add('helper-registration__inputs--disabled')
    }

    toggleRegistration() {
        if (this.checkboxTarget.checked)  this.enable()
        else this.disable()
    }

    connect() {
        if (this.checkboxTarget.checked) this.enable()
    }
}
