(use-modules (ice-9 ftw))

(load ".dotxbindkeys/lib/keymap.scm")
(load ".dotxbindkeys/lib/message.scm")
(load ".dotxbindkeys/lib/functions.scm")

;; load plugins
(map (lambda (scm)
       (display (string-append "Loading Plugin: " scm "\n"))
       (load scm))
     (map (lambda (child)
            (string-append ".dotxbindkeys/plugins/" (car child)
                           "/" (car child)
                           ".scm"))
          (cdr (cdr (file-system-tree
                     (string-append (dirname (current-filename))
                                    ".dotxbindkeys/plugins"))))))

;; include user's scheme
(load ".dotxbindkeys/user/user.scm")
