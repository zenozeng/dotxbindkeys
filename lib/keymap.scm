(define keybindings '())

(define (define-key keymap key binding)
  (define keybinding '())
  (set! keybinding (acons "keymap" keymap keybinding))
  (set! keybinding (acons "key" key keybinding))
  (set! keybinding (acons "binding" binding keybinding))
  (set! keybindings (append keybindings (list keybinding))))

(define (set-keymap keymap)

  (define active-keybindings
    (filter (lambda (keybinding)
              (or (equal? (assoc-ref keybinding "keymap")
                          keymap)
                  (equal? (assoc-ref keybinding "keymap")
                          "global")))
            keybindings))

  (define active-keys
    (delete-duplicates (map (lambda (keybinding)
                              (assoc-ref keybinding "key"))
                            active-keybindings)))

  (define (apply-callbacks key)
    (map display (list "APPLY CALLBACKS: " key "\n"))
    (map (lambda (keybinding)
           ((assoc-ref keybinding "binding")))
         (filter (lambda (keybinding)
                   (equal? key (assoc-ref keybinding "key")))
                 active-keybindings)))

  (map display (list "Switch to keymap: " keymap "\n"))

  (display keybindings)
  
  (ungrab-all-keys)
  (remove-all-keys)
  (map (lambda (key)
         (xbindkey-function key (lambda ()
                                  (apply-callbacks key))))
       active-keys)
  (grab-all-keys))
