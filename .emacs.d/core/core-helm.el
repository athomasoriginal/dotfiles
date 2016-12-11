;;; core-helm.el

(require 'cl-lib)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; helm defuns

; replace the helm prompt
(defun kong*helm-replace-prompt (plist)
  (if (keywordp (car plist))
      (setq plist (plist-put plist :prompt helm-global-prompt))
    (setcar (nthcdr 2 plist) helm-global-prompt))
  plist)

; supposed to hide the helm header...not sure if it works
(defun kong*helm-hide-header (source &optional force)
    (kong-hide-mode-line-mode +1))

; does what the above does, expect only on a certain condition
; not sure what this does
(defun kong*helm-hide-source-header-maybe ()
  (if (<= (length helm-sources) 1)
      (set-face-attribute 'helm-source-header nil :height 0.1 :foreground "#111111")
    (set-face-attribute 'helm-source-header nil :height 1.0 :foreground kong-helm-header-fg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; helm configuration

(use-package helm
    :init
    (setq helm-quick-update t
          helm-mode-fuzzy-match nil
          helm-buffers-fuzzy-matching nil
          helm-apropos-fuzzy-match nil
          helm-M-x-fuzzy-match nil
          helm-recentf-fuzzy-match nil
          helm-projectile-fuzzy-match nil
          helm-ff-auto-update-initial-value nil
          helm-find-files-doc-header nil
          helm-candidate-number-limit 50
          helm-display-header-line nil            ; Display extraineous helm UI elements
          helm-move-to-line-cycle-in-source t)    ; Don't wrap item cycling

    ;; Helm key bindings
    :bind

    (("<tab>"   . helm-execute-persistent-action)
     ("C-x b"   . helm-buffers-list)
     ("C-x m"   . helm-M-x)
     ("M-y"     . helm-show-kill-ring)
     ("C-x C-f" . helm-find-files))

    ;; Helm UI Enhancements
    :config

    (defvar helm-global-prompt "››› ")                                                ; used in kong*helm-hide-header
    (defconst kong-helm-header-fg (face-attribute 'helm-source-header :foreground))   ; used in kong*helm-hide-source-header-maybe

    (advice-add 'helm :filter-args 'kong*helm-replace-prompt)                         ; the prompt becomes '>>>'
    (advice-add 'helm-display-mode-line :override 'kong*helm-hide-header)             ; Hide mode-line in helm windows
    (add-hook   'helm-after-initialize-hook 'kong*helm-hide-source-header-maybe)      ; not sure what this does

    ;; activate helm-mode

    (require 'helm-mode)
    (helm-mode +1))


; export core-which-key
(provide 'core-helm)
