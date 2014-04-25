# dotxbindkeys

Xbindkeys Configuration Framework

## Usage

### Start

`dotxbindkeys`

### Debug Mode

`dotxbindkeys -v`

### Send Message to xbindkeys

```scheme
(add-hook! receive-message-hook
           (lambda (msg)
             (display msg)))
```

```shell
dotxbindkeys-send-message "Hello World"
```

## FAQ

### Why not use Guile's modules?

I want to use functions (xbindkey-function, ungrab-all-keys, remove-all-keys, etc) provided by xbindkeys, but they are unbound variable in module. So, I simply use include here.

## Ref

- http://www.gnu.org/software/guile/manual/html_node/Hook-Example.html#Hook-Example

- http://www.cnblogs.com/youxin/p/3427087.html
