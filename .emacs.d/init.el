; http://cask.readthedocs.io/en/latest/guide/usage.html

; tell kong where to find cask

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)

; load core
(load (concat user-emacs-directory "core/core"))

(load-local "core-ui-elements") ; load base ui elements
(load-local "core-os-osx")      ; load macOS custom configurations
(load-local "core-which-key")   ; load which-key
(load-local "core-helm")        ; load helm


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d5c073edd9a97b8821cc2e11bc60c84c1da7622e1bf952e37e0e0495cb5c136f" "0329193aa6a36d25039e5588febd207c29f68203f743a639fdbbd7bf89c07891" "0bd765b5d1c8bf6028e3280b31601c7e1cd745118920ab9dc0a6a14fe9b92804" default)))
 '(package-selected-packages
   (quote
    (exec-path-from-shell which-key use-package try helm color-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
