;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; core-ui-elements.el

(tooltip-mode -1)             ; GUI - hide the tool bar
(menu-bar-mode -1)            ; GUI - don't show menu bar
(fset 'yes-or-no-p 'y-or-n-p) ; yes or no question with y or n

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ui stuff

; symbols
(put 'kong-hide-mode-line-mode 'permanent-local t)
(put 'kong--mode-line 'permanent-local t)

; variables
(defvar kong-hide-mode-line-format nil
  "Format to use when `kong-hide-mode-line-mode' replaces the modeline")

(defvar-local kong--mode-line nil)

; autoload
(define-minor-mode kong-hide-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global nil
  (if kong-hide-mode-line-mode
      (setq kong--mode-line mode-line-format
            mode-line-format kong-hide-mode-line-format)
    (setq mode-line-format kong--mode-line
          kong--mode-line kong-hide-mode-line-format)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; export the core-ui-elements module
(provide 'core-ui-elements)
