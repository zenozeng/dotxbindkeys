(add-to-load-path (dirname (current-filename)))
(load "base.scm")

(use-modules ((dotxbindkeys base)))
(set-xbindkey-function xbindkey-function)
(set-ungrab-all-keys ungrab-all-keys)
(set-remove-all-keys remove-all-keys)

(load "share.scm")
(load "user.scm")
((@ (dotxbindkeys share) reset-keys))
((@ (dotxbindkeys user) init))
