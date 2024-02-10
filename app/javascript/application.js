// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as turbo from '@hotwired/turbo'
import './controllers/index'
import { clearFormerror } from "./utils/formutils";
import { squashImageFile } from "./utils/image_utils";
import { resendParentVerificationEMail } from "./utils/apis";

window.clearFormerror = clearFormerror
window.squashImageFile = squashImageFile
window.resendParentVerificationEMail = resendParentVerificationEMail

turbo.start()
