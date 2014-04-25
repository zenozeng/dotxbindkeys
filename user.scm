(define-module (dotxbindkeys user)
  #:export (init))

(use-modules ((dotxbindkeys share)))

(define (init)
  (add-hook! receive-message-hook
             (lambda (msg)
               (display msg)))
  (display "user::init"))
