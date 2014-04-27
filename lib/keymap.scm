(define keybindings '())

(define (define-key keymap key binding)
  (set! keybindings (append keybindings '((keymap key binding)))))

(define (set-keymap keymap)

  (define active-keybindings
    (filter (lambda (keybinding)
              (or (equal? (car keybinding) keymap)
                  (equal? (car keybinding) "global")))
            keybindings))
  (define active-keys
    (delete-duplicates (map car active-keybindings)))

  (define (apply-callbacks key)
    (map display "APPLY CALLBACKS: " key "\n")
    (map (lambda (keybinding)
           ((car (cdr (cdr keybinding)))))
         (filter (lambda (keybinding)
                   (equal? key (car (cdr keybinding))))
                 active-keybindings)))

  (ungrab-all-keys)
  (remove-all-keys)
  (map (lambda (key)
         (xbindkey-function key (lambda ()
                                  (apply-callbacks key))))
       active-keys)
  (grab-all-keys))
