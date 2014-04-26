(use-modules (ice-9 ftw))

;; include share functions
; (include "share.scm")
(load "share.scm")

;; include plugins
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

;; init key bindings
(reset-keys)
