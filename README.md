# dotxbindkeys

Xbindkeys Configuration Framework

Current Version: 0.1.1

## Install

```
sudo apt-get install xbindkeys xdotool
git clone https://github.com/zenozeng/dotxbindkeys.git
cd dotxbindkeys
./install.sh
```

## Usage

### Start

`xbindkeys`

### Debug Mode

`xbindkeys -v`

## API

### Bind/Press keys

Example: send F5 when control+r pressed

```scheme
(define-key "global" '(control r) (lambda () (press "F5")))
```

### Send Message to xbindkeys

```scheme
(add-hook! receive-message-hook
           (lambda (msg)
             (display msg)))
```

```shell
dotxbindkeys-send-message "Hello World"
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

### Guile Modules

`(ice-9 ftw)` and `(srfi srfi-1)` are avaiable by default.

- http://www.gnu.org/software/guile/manual/html\_node/SRFI\_002d1.html#SRFI\_002d1

### Why use string for keymap?

This is allow to define-key before defining that keymap.

## License

GPLv3

## Ref

- http://www.gnu.org/software/guile/manual/html_node/Hook-Example.html#Hook-Example

- http://www.cnblogs.com/youxin/p/3427087.html
