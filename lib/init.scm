(use-modules (ice-9 ftw) (srfi srfi-1) (srfi srfi-13) (ice-9 threads))

(map (lambda (lib)
       (load (string-append "/usr/local/lib/dotxbindkeys/" lib ".scm")))
     (list "message" "keymap" "functions"))

(define dotxbindkeys-path (string-append "/home/" (getlogin) "/.dotxbindkeys/"))

(map (lambda (scm)
       (display (string-append "Loading Plugin: " scm "\n"))
       (load scm))
     (map (lambda (child)
            (string-append dotxbindkeys-path
                           "plugins/" (car child)
                           "/" (car child)
                           ".scm"))
          (drop (file-system-tree
                     (string-append dotxbindkeys-path "plugins"))
                2)))

(load (string-append dotxbindkeys-path "user.scm"))
(set-keymap "global")
