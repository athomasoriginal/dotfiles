;;; core-os-osx.el --- Mac-specific settings
;;; taken from https://github.com/hlissner/.emacs.d/blob/master/core/core-os-osx.el
;;  The following makes things like scrolling and generaly using emacs on osx
;;  a nicer experience.

(setq mac-command-modifier 'meta              ; Prefixes: Command = M, Alt = A - osx
      mac-option-modifier  'alt               ; sane trackpad/mouse scroll settings - osx
      mac-redisplay-dont-reset-vscroll t
      mac-mouse-wheel-smooth-scroll nil
      mouse-wheel-scroll-amount     '(5 ((shift) . 2)) ; one line at a time
      mouse-wheel-progressive-speed nil                ; don't accelerate scrolling
      ns-use-native-fullscreen      nil                ; turn off native full screen
      ns-pop-up-frames              nil)               ; Don't open files from the workspace in a new frame


;; make sure the GUI emacs environment knows about shell variable in .zshrc
;; this seems to cause a lot of slowdown for emacs.  Work on fixing this.
(use-package exec-path-from-shell
  :ensure t
  :config
  (setenv "SHELL" "~/.zshrc")
  (setq exec-path
        (eval-when-compile
          (require 'exec-path-from-shell)
          (exec-path-from-shell-initialize)
          exec-path)))
