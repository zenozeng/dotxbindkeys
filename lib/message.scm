(define receive-message-hook (make-hook 1))

;; (define (read-message)
;;   (define (read-file filename)
;;     (if (access? filename R_OK)
;;         (call-with-input-file filename
;;           (lambda (port)
;;             (let ((str "")
;;                   (c (read-char port)))
;;               (while (not (eof-object? c))
;;                      (if (not (equal? c #\newline))
;;                          (set! str (string-append str (string c))))
;;                      (set! c (read-char port)))
;;               str)))
;;         ""))
;;   (system "echo $(date +%s) > /tmp/dotxbindkeys-echo")
;;   (read-file "/tmp/dotxbindkeys"))

(define (pull-messages)
  (let ((s (socket PF_INET SOCK_STREAM 0)))
    (connect s AF_INET (inet-pton AF_INET "127.0.0.1") 80)
    (display "GET / HTTP/1.0\r\n\r\n" s)

    (do ((line (read-line s) (read-line s)))
        ((eof-object? line))
      (display line)
      (newline)))

  (run-hook receive-message-hook msgs))

(define (listen-for-messages)
  (xbindkey-function '(alt shift F12) pull-messages))
(listen-for-messages)
