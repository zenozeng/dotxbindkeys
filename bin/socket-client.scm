(use-modules (rnrs bytevectors))

(define message-server
  (lambda (op . args)

    (define (connect-server)
      (let* ((s (socket PF_UNIX SOCK_STREAM 0))
             (address
              (make-socket-address AF_UNIX "/tmp/dotxbindkeys.sock")))
        (connect s address)
        s))

    (define (push msg)
      (let ((s (connect-server)))
        (write 'push s)
        (write msg s)
        (close s)))

    (if (equal? op 'push)
        (push (car args)))
    (if (equal? op 'pull)
        (pull))))


(message-server 'push "test1")
(message-server 'push "test2")
(message-server 'pull)
