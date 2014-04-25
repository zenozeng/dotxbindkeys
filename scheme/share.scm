(define reset-keys-hook (make-hook))
(define receive-message-hook (make-hook 1))

(define (reset-keys)
  (ungrab-all-keys)
  (remove-all-keys)
  (run-hook reset-keys-hook))

(define (bind-run-receive-message-hook)

  (define (read-file filename)
    (if (access? filename R_OK)
        (call-with-input-file filename
          (lambda (port)
            (let ((chars '())
                  (c (read-char port)))
              (while (not (eof-object? c))
                     (set! chars (append chars '(c)))
                     (set! c (read-char port)))
              (list->string chars))))
        ""))

  (xbindkey-function '(alt shift F12)
                     (lambda ()
                       (run-hook receive-message-hook (read-file "/tmp/dotxbindkeys")))))

(add-hook! reset-keys-hook bind-run-receive-message-hook)
