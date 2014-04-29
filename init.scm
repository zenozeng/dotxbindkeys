(use-modules (ice-9 ftw) (srfi srfi-1) (srfi srfi-13) (ice-9 threads))

(load ".dotxbindkeys/lib/message.scm")
(load ".dotxbindkeys/lib/keymap.scm")
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
(switch-to-keymap "global")
