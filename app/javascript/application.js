// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails'
import 'controllers/index'
import { clearFormerror } from './utils/formutils';
import { squashImageFile } from "./utils/image_utils";

window.clearFormerror = clearFormerror
window.squashImageFile = squashImageFile
