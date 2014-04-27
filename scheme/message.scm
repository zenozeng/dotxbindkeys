(define receive-message-hook (make-hook 1))

(define (read-message)
  (define (read-file filename)
    (if (access? filename R_OK)
        (call-with-input-file filename
          (lambda (port)
            (let ((str "")
                  (c (read-char port)))
              (while (not (eof-object? c))
                     (if (not (equal? c #\newline))
                         (set! str (string-append str (string c))))
                     (set! c (read-char port)))
              str)))
        ""))
  (read-file "/tmp/dotxbindkeys"))

(define-key "global" '(alt shift F12)
  (lambda () (run-hook receive-message-hook (read-message))))
