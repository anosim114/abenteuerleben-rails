// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { Application } from '@hotwired/stimulus'
import "/fontawesome/js/solid.js"
import "/fontawesome/js/regular.js"
import "/fontawesome/js/fontawesome.js"
import 'controllers'

const application = Application.start()

window.Stimulus = application

export { application }
