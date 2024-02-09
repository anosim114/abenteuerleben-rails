# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "controllers/index", to: "controllers/index.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/utils", under: "utils"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@toast-ui/editor", to: "@toast-ui--editor.js" # @3.2.2
pin "orderedmap" # @2.1.1
pin "prosemirror-commands" # @1.5.2
pin "prosemirror-history" # @1.3.2
pin "prosemirror-inputrules" # @1.3.0
pin "prosemirror-keymap" # @1.2.2
pin "prosemirror-model" # @1.19.4
pin "prosemirror-state" # @1.4.3
pin "prosemirror-transform" # @1.8.0
pin "prosemirror-view" # @1.32.7
pin "rope-sequence" # @1.3.4
pin "w3c-keyname" # @2.2.8
pin "sweetalert" # @2.1.2
pin "process" # @2.0.1
