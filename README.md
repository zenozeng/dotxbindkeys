# dotxbindkeys

Xbindkeys Configuration Framework

Current Version: 0.1.2

## Install

```
sudo apt-get install xbindkeys xdotool
git clone https://github.com/zenozeng/dotxbindkeys.git
cd dotxbindkeys
./install.sh
```

## Usage

### Start

`dotxbindkeys start`

### Debug Mode

`dotxbindkeys debug`

## API

### Bind/Press keys

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

## FAQ

### Why not use Guile's modules?

I want to use functions (xbindkey-function, ungrab-all-keys, remove-all-keys, etc) provided by xbindkeys, but they are unbound variable in module. So, I simply use `load` here.

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

### Guile Modules

`(ice-9 ftw)` and `(srfi srfi-1)` are avaiable by default.

- http://www.gnu.org/software/guile/manual/html\_node/SRFI\_002d1.html#SRFI\_002d1

### Why use string for keymap?

This is allow to define-key before defining that keymap.

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
