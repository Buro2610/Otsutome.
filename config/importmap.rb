# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/custom",      under: "custom"



pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.0/dist/jquery.js"
pin "datatables.net", to: "https://ga.jspm.io/npm:datatables.net@1.13.3/js/jquery.dataTables.mjs"
pin "jquery-ui", to: "https://ga.jspm.io/npm:jquery-ui@1.13.2/ui/widget.js"

