# dotxbindkeys

Xbindkeys Configuration Framework

Current Version: 0.3.0

## Install

```
sudo apt-get install xbindkeys xdotool netcat-openbsd
git clone https://github.com/zenozeng/dotxbindkeys.git
cd dotxbindkeys
sudo ./install.sh
```

## Usage

### Start

`dotxbindkeys start`

### Debug Mode

`dotxbindkeys debug`

## API

### Define Key

```scheme
(define-key "keymap-name" key (lambda () (do-sth)))
```

key is sth like `'(control f)`.

### Set Keymap

```scheme
(set-keymap "keymap-name")
```

Switch to given keymap.  
Note that all the keybindings in keymap `global` will be included.

```scheme
(set-keymap-async "keymap-name")
```

Sometimes, when 2 keymaps contains the same key.
For example, `'(control space)` to enable set-mark-mode-keymap
and `'(control space)` to switch back.
Your may not be able to switch back if you use `set-keymap`.
I am not sure what caused it, but you can use `set-keymap-async`
if you encounter this problem.

### Simulate keystrokes

Simulate keystrokes (will ungrab all keys before that)

Example: send F5 when control+r pressed

```scheme
(define-key "global" '(control r) (lambda () (press "F5")))
```

Example: send Shift+End and Delete when control+k pressed

```scheme
(define-key "global"
  '(control k)
  (lambda () (press (list "Shif+End"
                          "Delete"))))
```

### Release keys

```scheme
(keyup keys)
```

Example: release shift

```scheme
(keyup "shift")
```

Example: release shift and control

```scheme
(keyup (list "shift" "control"))
```

### Send Message to xbindkeys

```scheme
(add-hook! receive-message-hook
           (lambda (msg)
             (display msg)))
```

```shell
dotxbindkeys send-message "Hello World"
```

### Install a plugin?

Example from [xbindkeys-chromemacs](https://github.com/zenozeng/xbindkeys-chromemacs):

```
mkdir -p ~/.dotxbindkeys/plugins/chromemacs
cp -f chromemacs.scm ~/.dotxbindkeys/plugins/chromemacs
```

Note that chromemacs.scm is the `init.scm` for plugins/chromemacs.

## FAQ

### How to identify one key pressed?

`xbindkeys -k`

### Can't grab all keys?

You may get this warning if you have more than one `xbindkeys` started.

```
*** Warning ***
Please verify that there is not another program running
which captures one of the keys captured by xbindkeys.
It seems that there is a conflict, and xbindkeys can't
grab all the keys defined in its configuration file.
```

### Why not use Guile's modules?

I want to use functions (xbindkey-function, ungrab-all-keys, remove-all-keys, etc) provided by xbindkeys, but they are unbound variable in module. So, I simply use `load` here.

### Why use string for keymap?

This allows to define-key before defining that keymap.

### What is the code of Super?

use `mod4` instead.

### Rescue super from Gnome Shell?

This will disable default Gnome Shell Super Key Mapping:

`gsettings set org.gnome.mutter overlay-key ''`

see alse: http://superuser.com/questions/484686/disable-default-gnome-shell-super-key-mapping

### Why use a hotkey to send message? Why not a daemon in scheme?

I have tried `thread`, `sleep` and `system-set-mark prec thread`. But no luck.
Seems that after about 100ms `(system-set-mark prec main-thread)` will nerver counts.

Anyway, if you find a more elegant way to send message, feel free to pull request.

## License

GPLv3

## Ref

- http://www.gnu.org/software/guile/manual/html_node/Hook-Example.html#Hook-Example

- http://www.cnblogs.com/youxin/p/3427087.html

- http://www.nongnu.org/xbindkeys/xbindkeysrc.scm.html

- http://www.nongnu.org/xbindkeys/xbindkeysrc-combo.scm.html
