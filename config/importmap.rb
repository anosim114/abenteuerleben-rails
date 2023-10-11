# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "controllers/index", to: "controllers/index.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@toast-ui/editor", to: "https://ga.jspm.io/npm:@toast-ui/editor@3.2.2/dist/esm/index.js"
pin "orderedmap", to: "https://ga.jspm.io/npm:orderedmap@2.1.1/dist/index.js"
pin "prosemirror-commands", to: "https://ga.jspm.io/npm:prosemirror-commands@1.5.2/dist/index.js"
pin "prosemirror-history", to: "https://ga.jspm.io/npm:prosemirror-history@1.3.2/dist/index.js"
pin "prosemirror-inputrules", to: "https://ga.jspm.io/npm:prosemirror-inputrules@1.2.1/dist/index.js"
pin "prosemirror-keymap", to: "https://ga.jspm.io/npm:prosemirror-keymap@1.2.2/dist/index.js"
pin "prosemirror-model", to: "https://ga.jspm.io/npm:prosemirror-model@1.19.3/dist/index.js"
pin "prosemirror-state", to: "https://ga.jspm.io/npm:prosemirror-state@1.4.3/dist/index.js"
pin "prosemirror-transform", to: "https://ga.jspm.io/npm:prosemirror-transform@1.7.5/dist/index.js"
pin "prosemirror-view", to: "https://ga.jspm.io/npm:prosemirror-view@1.31.7/dist/index.js"
pin "rope-sequence", to: "https://ga.jspm.io/npm:rope-sequence@1.3.4/dist/index.js"
pin "w3c-keyname", to: "https://ga.jspm.io/npm:w3c-keyname@2.2.8/index.js"
pin_all_from "app/javascript/controllers", under: "controllers"
