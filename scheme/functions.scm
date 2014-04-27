(define (press key)
  "Ungrab all keys and press key using xdotool, then grab all keys"
  (ungrab-all-keys)
  (run-command (string-append "xdotool getwindowfocus key --clearmodifiers " key))
  (grab-all-keys))
