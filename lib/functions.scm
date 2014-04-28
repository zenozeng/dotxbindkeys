(define (press keys)
  "Ungrab all keys and press key using xdotool, then grab all keys"
  (define cmd
    (apply string-append
           (cons "xdotool getwindowfocus "
                 (map (lambda (key)
                        (string-append " key --clearmodifiers " key))
                      (if (list? keys)
                          keys
                          (list keys))))))
  (ungrab-all-keys)
  (run-command cmd)
  (grab-all-keys))
