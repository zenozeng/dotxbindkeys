(define-module (dotxbindkeys share)
  #:export (reset-keys reset-keys-hook receive-message-hook))

(use-modules ((dotxbindkeys base)))

(define reset-keys-hook (make-hook))
(define receive-message-hook (make-hook))

(define (reset-keys)
  (xbindkey-function '(control u) (lambda () #f))
  (ungrab-all-keys)
  (remove-all-keys)
  (run-hook reset-keys-hook))

(add-hook! reset-keys-hook
           (lambda ()
             (xbindkey-function '(alt shift F12)
                                (lambda ()
                                  (define msg "hello world")
                                  (run-hook receive-message-hook msg)))))
