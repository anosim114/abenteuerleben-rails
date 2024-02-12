import * as turbo from '@hotwired/turbo'
import './controllers/index'
import { clearFormerror } from "./utils/formutils";
import { squashImageFile } from "./utils/image_utils";
import { resendParentVerificationEMail } from "./utils/apis";

window.clearFormerror = clearFormerror
window.squashImageFile = squashImageFile
window.resendParentVerificationEMail = resendParentVerificationEMail