(use-modules (ice-9 ftw) (srfi srfi-1))

(load ".dotxbindkeys/lib/keymap.scm")
(load ".dotxbindkeys/lib/message.scm")
(load ".dotxbindkeys/lib/functions.scm")

(map (lambda (scm)
       (display (string-append "Loading Plugin: " scm "\n"))
       (load scm))
     (map (lambda (child)
            (string-append ".dotxbindkeys/plugins/" (car child)
                           "/" (car child)
                           ".scm"))
          (drop (file-system-tree
                     (string-append (dirname (current-filename))
                                    "/.dotxbindkeys/plugins"))
                2)))

(load ".dotxbindkeys/user/user.scm")
(set-keymap "global")