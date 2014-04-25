(require "user.scm")

; Load module, allowing access to all exported items, and uses 
; specified prefix, 'ym:, to refer to module items
(use-modules ((your-module)
              :renamer (symbol-prefix-proc 'ym:)) )

; Access module members
(print ym:version)
