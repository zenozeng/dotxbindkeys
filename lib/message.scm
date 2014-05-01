(define receive-message-hook (make-hook 1))

(define *dotxbindkeys-messages* '())

(define (dispatch-messages)
  (while (not (null? *dotxbindkeys-messages*))
         (let ((msg (format #f "~a" (car *dotxbindkeys-messages*))))
           (map display (list "\nDispatch message: "
                              msg
                              "\n"))
           (run-hook receive-message-hook msg)
           (set! *dotxbindkeys-messages* (cdr *dotxbindkeys-messages*)))))

(define (listen-for-messages)
  (xbindkey-function '(control F12) dispatch-messages))
(listen-for-messages)

(begin-thread
 (system "rm -rf /tmp/dotxbindkeys.sock")

 (let ((s (socket PF_UNIX SOCK_STREAM 0))
       (sock-addr (make-socket-address AF_UNIX "/tmp/dotxbindkeys.sock"))
       (messages '()))

   (setsockopt s SOL_SOCKET SO_REUSEADDR 1)
   (bind s sock-addr)
   (listen s 5)

   (while #t
          (let* ((client-connection (accept s))
                 (client-details (cdr client-connection))
                 (client (car client-connection))
                 (eol "\n"))
            (map display (list eol "message-server> new client" eol))
            (let ((data (read client)))
              (map display (list eol "message-server> recv: " data eol))
              (set! *dotxbindkeys-messages* (append *dotxbindkeys-messages* (list data))))
            (close client)))))
