(define-module (dotxbindkeys base)
  #:export (xbindkey-function ungrab-all-keys remove-all-keys))

(define (xbindkey-function) (lambda () #f))
(define (ungrab-all-keys) (lambda () #f))
(define (remove-all-keys) (lambda () #f))

(define (set-xbindkey-function fn)
  (set! xbindkey-function fn))
(define (set-ungrab-all-keys fn)
  (set! ungrab-all-keys fn))
(define (set-remove-all-keys fn)
  (set! remove-all-keys fn))
