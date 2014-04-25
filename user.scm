; Module name and source file names match -> your-module.scm
(define-module (your-module))

; Module's 'interface' - set of exported / publically-accessable items
(define-public version "1.2")

(define-public (a-public-proc arg) "a-public-proc")
(define-public (another-public-proc arg) "another-public-proc")
