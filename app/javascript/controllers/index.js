import { Application } from '@hotwired/stimulus'
import Dialog_checkbox_controller from "./dialog_checkbox_controller";
import Helperregistration_controller from "./helperregistration_controller";

const application = Application.start()
window.Stimulus = application

application.register('dialog-checkbox', Dialog_checkbox_controller)
application.register('helperregistration', Helperregistration_controller)
