;; Network Socket Examples
;; http://www.gnu.org/software/guile/manual/html_node/Internet-Socket-Examples.html
;; Unix Socket Example
;; http://lists.gnu.org/archive/html/guile-user/2013-07/msg00000.html

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
           (map display (list "\n> conn" eol))
           (let ((cmd (read client)))
             (if (equal? cmd 'push)
                 (let ((content (read client)))
                   (map display (list "> push" eol))
                   (map display (list "> " content eol))
                   (set! messages (append messages (list content)))))
             (if (equal? cmd 'pull)
                 (begin
                   (map display (list "> pull" eol))
                   (while (not (null? messages))
                          (write (car messages) client)
                          (write eol client)
                          (set! messages (cdr messages))))))
           (close client))))
