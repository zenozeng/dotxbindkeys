(use-modules (ice-9 ftw))

(load "keymap.scm")
(load "message.scm")
(load "functions.scm")

;; load plugins
(map (lambda (scm)
       (display (string-append "Loading Plugin: " scm "\n"))
       (load scm))
     (map (lambda (child)
            (string-append "plugins/" (car child)
                           "/" (car child)
                           ".scm"))
          (cdr (cdr (file-system-tree
                     (string-append (dirname (current-filename))
                                    "/plugins"))))))

;; include user's scheme
(load "user.scm")
