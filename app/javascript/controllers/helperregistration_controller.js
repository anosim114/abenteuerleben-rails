import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["checkbox", "wishFirst", "wishSecond", "wishFirstBox", "wishSecondBox"]

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

        this.activatePreferredCampInputBox()
    }

    activatePreferredCampInputBox() {
        const checkedTeamsLength = Array.from(document.querySelectorAll('.helper-registration__checkbox'))
                                        .filter(checkbox => checkbox.checked)
                                        .length

        const preferredCampElement = document.querySelector('#helper_preferredCamp')
        
        if (checkedTeamsLength > 1) {
            preferredCampElement.disabled = false
            preferredCampElement.parentElement.classList.remove('d-none')
        } else {
            preferredCampElement.disabled = true
            preferredCampElement.parentElement.classList.add('d-none')
        }
    }

    toggleWishFirstBox() {
        if (this.wishFirstTarget.value === "Sonstiges") {
            this.wishFirstBoxTarget.classList.remove('helper-registration__wish-box--disabled')
            this.wishFirstBoxTarget.disabled = false
        } else {
            this.wishFirstBoxTarget.classList.add('helper-registration__wish-box--disabled')
            this.wishFirstBoxTarget.disabled = true
            this.wishFirstBoxTarget.value = ''
        }
    }

    toggleWishSecondBox() {
        if (this.wishSecondTarget.value === "Sonstiges") {
            this.wishSecondBoxTarget.classList.remove('helper-registration__wish-box--disabled')
            this.wishSecondBoxTarget.disabled = false
        } else {
            this.wishSecondBoxTarget.classList.add('helper-registration__wish-box--disabled')
            this.wishSecondBoxTarget.disabled = true
            this.wishSecondBoxTarget.value = ''
        }
    }

    connect() {
        if (this.checkboxTarget.checked) this.enable()
        
        this.activatePreferredCampInputBox()
    }
}
