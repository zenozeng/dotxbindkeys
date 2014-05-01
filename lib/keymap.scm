;; Require: message.scm

(define keybindings '())

(define (define-key keymap key binding)
  (define keybinding '())
  (set! keybinding (acons "keymap" keymap keybinding))
  (set! keybinding (acons "key" key keybinding))
  (set! keybinding (acons "binding" binding keybinding))
  (set! keybindings (append keybindings (list keybinding))))

(define (set-keymap keymap)
  "Switch to the given keymap now"

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

  (map display (list "\nSwitch to keymap: [" keymap "]\n"))

  (ungrab-all-keys)
  (remove-all-keys)
  (listen-for-messages)
  (map (lambda (key)
         (xbindkey-function key (lambda ()
                                  (apply-callbacks key))))
       active-keys)
  (grab-all-keys))

(add-hook! receive-message-hook
           (lambda (msg)
             (if (string-prefix? "set-keymap::" msg)
                 (begin
                   (set-keymap
                    (string-replace msg "" 0 12))))))

(define (set-keymap-async keymap)
  ;; a workround for #5
  ;; using send-message will be change current key to (alt shift F12)
  (run-command (string-append
           "dotxbindkeys send-message 'set-keymap::" keymap "'")))
