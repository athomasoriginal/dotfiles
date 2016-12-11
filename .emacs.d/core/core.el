;;; Naming conventions:
;;
;;   kong-...     A public variable/constant or function
;;   kong--...    An internal variable or function (non-interactive)
;;   kong/...     An autoloaded function
;;   kong:...     An ex command
;;   kong|...     A hook
;;   kong*...     An advising function
;;   ...!         Macro, shortcut alias or subst defun
;;   @...         Autoloaded interactive lambda macro for keybinds
;;
;;; Autoloaded functions are in {core,modules}/defuns/defuns-*.el
; This is a basic setup file.  Mostly, you will not need to do anything in here

;; Premature optimization for faster startup
(setq-default gc-cons-threshold 339430400
              gc-cons-percentage 0.6)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global Constants

(defconst kong-version "1.3.0"
  "Current version of kong emacs")

(defconst kong-emacs-dir
  (expand-file-name user-emacs-directory)
  "The path to this emacs.d directory")

(defconst kong-core-dir
  (expand-file-name "core" kong-emacs-dir)
  "Where essential files are stored")

(defconst kong-modules-dir
  (expand-file-name "modules" kong-emacs-dir)
  "Where configuration modules are stored")

(defconst kong-packages-dir
  (expand-file-name
   (format ".cask/%s.%s/elpa" emacs-major-version emacs-minor-version)
   kong-emacs-dir)
  "Where plugins are installed (by cask)")

(defvar kong-unicode-font
  (font-spec :family "DejaVu Sans Mono" :size 12)
  "Fallback font for unicode glyphs.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Core configuration

;; UTF-8 as the default coding system, please
(set-charset-priority        'unicode)
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)

;; tells cask to be my hero
(setq-default
 package--init-file-ensured t
 package-user-dir kong-packages-dir
 package-enable-at-startup nil
 package-archives
 '(("gnu"   . "https://elpa.gnu.org/packages/")
   ("melpa" . "https://melpa.org/packages/")
   ("org"   . "https://orgmode.org/elpa/")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap

(defun load-local (file)
  (load (f-expand file kong-core-dir)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; export

(provide 'core)
