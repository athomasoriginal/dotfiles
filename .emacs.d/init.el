;;
;; Customizations groked from https://mickael.kerjean.me/2017/03/19/emacs-tutorial-series-episode-1/
;;

;; -----------------------------------------------------------------------------
;; Theme + Fonts
;; -----------------------------------------------------------------------------
(load-theme 'wombat)
;; a great font: https://www.fontyukle.net/en/Monaco.ttf
(condition-case nil
    (set-default-font "Monaco")
  (error nil))

;; -----------------------------------------------------------------------------
;; Custom Set Faces
;; -----------------------------------------------------------------------------
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#242424" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "APPL" :family "Monaco"))))
 '(fringe ((t (:background "#242424"))))
 '(linum ((t (:inherit (shadow default) :background "#191919" :foreground "#505050")))))

;; -----------------------------------------------------------------------------
;; GUI customizations
;; -----------------------------------------------------------------------------
(menu-bar-mode -1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(setq visible-bell 1)
(setq ring-bell-function 'ignore)

;; startup screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; remove whitespace before saving
(add-hook 'before-save-hook 'whitespace-cleanup)

;; highlight selected text
(transient-mark-mode t)

;; display matching parenthesis
(show-paren-mode 1)

;; display time
(load "time" t t)
(display-time)

;; track recently opened file
(recentf-mode t)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(setq recentf-max-saved-items 1000)
(setq recentf-max-menu-items 50)

;; display pictures and other compressed files
(setq auto-image-file-mode t)
(setq auto-compression-mode t)

;; line and column numbering
(column-number-mode 1)
(line-number-mode 1)

;; code folding
(global-set-key (kbd "C-c C-d") 'hs-hide-all)
(global-set-key (kbd "C-c C-f") 'hs-show-all)
(global-set-key (kbd "C-c C-c") 'hs-toggle-hiding)
(add-hook 'prog-mode-hook #'(lambda () (hs-minor-mode t)))

;; Search using regexp
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)

;; Usable on OSX and windows
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'alt)
(setq mac-right-option-modifier 'super)
(setq w32-get-true-file-attributes nil)
(setq vc-handled-backends nil)
(remove-hook 'find-file-hooks 'vc-find-file-hook)

;; scroll
(setq scroll-step 1)
(setq scroll-conservatively 10)
(setq scroll-margin 7)
(setq scroll-conservatively 5)

;; indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq standard-indent 4)
(setq indent-line-function 'insert-tab)
(setq tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq indent-tabs-mode nil)

;; disable backup files
(setq make-backup-files nil)

;; auto wraping
(set-default 'truncate-lines t)
(add-hook 'text-mode-hook (lambda () (setq truncate-lines nil)))

;; setup ido for selecting file
(ido-mode)
(setq ido-enable-flex-matching t)
(setq resize-mini-windows t)
(add-hook 'minibuffer-setup-hook
      (lambda () (setq truncate-lines nil)))
(setq ido-decorations '("\n-> " "" "\n   " "\n   ..."
                        "[" "]" " [No match]" " [Matched]"
                        " [Not readable]" " [Too big]" " [Confirm]"))
(add-to-list 'ido-ignore-buffers "*Messages*")
(add-to-list 'ido-ignore-buffers "*Buffer*")
(add-to-list 'ido-ignore-buffers "*ESS*")
(add-to-list 'ido-ignore-buffers "*NeoTree*")
(add-to-list 'ido-ignore-buffers "*Completions*")
(add-to-list 'ido-ignore-buffers "*Help*")
(custom-set-faces
 '(ido-subdir ((t (:inherit 'font-lock-keyword-face))))
 '(ido-first-match ((t (:inherit 'font-lock-comment-face))))
 '(ido-only-match ((t (:inherit 'font-lock-comment-face)))))


;; line wrap
(setq linum-format "%d ")

;; EWW - emacs web browser
(setq eww-search-prefix "https://www.google.com.au/search?q=")
(setq shr-color-visible-luminance-min 78) ;; improve readability (especially for google search)
(setq url-user-agent "User-Agent: Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7\n")
(global-set-key (kbd "C-c b") 'eww)

;; -----------------------------------------------------------------------------
;; Shortcuts
;; -----------------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;; move faster up and down faster
(global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
(global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))

;; usefull stuff before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'before-save-hook '(lamdba () (require 'saveplace)(setq-default save-place t)))

;; set path
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(add-to-list 'exec-path "/usr/local/bin")

;; refresh buffers when any file change
(global-auto-revert-mode t)

;; usefull shortcuts
(global-set-key [f3] 'comment-region)
(global-set-key [f4] 'uncomment-region)
(global-set-key [f5] 'eshell)
(global-set-key [f11] 'toggle-frame-fullscreen)
(global-set-key (kbd "C-h C-s") 'info-apropos)

;; ARTIST MODE
(eval-after-load "artist" '(define-key artist-mode-map [(down-mouse-3)] 'artist-mouse-choose-operation))


;; Setup the package manager
(defun load-package-manager ()
  (package-initialize)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/")))
(add-hook 'after-init-hook 'load-package-manager)

;; Hide left line indicator
(setf (cdr (assq 'continuation fringe-indicator-alist))
      '(nil nil)) ;; no continuation indicators
      ;; '(nil right-curly-arrow) ;; right indicator only
      ;; '(left-curly-arrow nil) ;; left indicator only
      ;; '(left-curly-arrow right-curly-arrow) ;; default

;; Window split line
(set-face-attribute 'vertical-border nil :foreground "#303030")

;; -----------------------------------------------------------------------------
;; Org Mode
;; -----------------------------------------------------------------------------

(setq org-todo-keywords (quote ((sequence "TODO(t)" "DOING(d)" "WAITING(w)" "|" "CANCEL(C)" "DEFERRED(F)" "DONE(D)"))))

(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(add-hook 'org-mode-hook 'org-loader)

(defun org-loader ()
  ;; mode related settings
  (org-indent-mode t)
  (setq truncate-lines nil)

  ;; capture & archive
  (setq org-default-notes-file "~/.emacs.d/files/default.org")
  (setq org-agenda-files (list "~/.emacs.d/files/"))
  (setq org-archive-location "~/.emacs.d/files/docs/archive.org::")
  (setq org-refile-targets (quote ((nil :maxlevel . 1) (org-agenda-files :maxlevel . 1))))
  (setq org-capture-templates
        (quote (("t" "todo" entry (file "~/.emacs.d/files/backlog.org")
                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                ("d" "doing" entry (file "~/.emacs.d/files/backlog.org")
                 "* BREAK %?\n%U\n%a\n" :clock-in t :clock-resume t))))

  ;; design
  (defvar org-level-star (make-face 'org-level-star))
  (font-lock-add-keywords 'org-mode (list (list (concat "\\*") '(0 org-level-star t))))
  (set-face-attribute 'org-level-star nil :inherit 'font-lock-comment-face)
  (set-face-attribute 'org-level-1 nil :inherit 'font-lock-keyword-face :height 125)
  (set-face-attribute 'org-level-2 nil :inherit 'font-lock-keyword-face :height 125)
  (set-face-attribute 'org-level-3 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-4 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-5 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-level-6 nil :inherit 'font-lock-keyword-face :height 115)
  (set-face-attribute 'org-link nil :inherit 'font-lock-warning-face)
  (set-face-attribute 'org-date nil :foreground (face-foreground 'font-lock-warning-face))
  (set-face-attribute 'org-tag nil :inherit 'font-lock-warning-face)

  ;; Task status and state
  (setq org-use-fast-todo-selection t)
  (add-hook 'org-after-todo-state-change-hook
            (lambda () (cond
                        ((and (org-entry-is-done-p) (org-clock-is-active)) (org-clock-out))
                        ((equal (org-get-todo-state) "DOING") (org-clock-in))
                        ((org-clock-is-active) (org-clock-out)))))

  ;; encrypt
  (require 'org-crypt)
  (require 'epa-file)
  (setq auto-save-default nil)
  (epa-file-enable)
  (org-crypt-use-before-save-magic)
  (setq org-tags-exclude-from-inheritance (quote ("crypt")))
  (setq org-crypt-key nil)
  (setq auto-save-default nil)
  ;;(global-set-key (kbd "C-c d") 'org-decrypt-entry)


  ;; org mode export
  (setq org-html-head "<meta http-equiv='X-UA-Compatible' content='IE=edge'><meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'><style>html{touch-action:manipulation;-webkit-text-size-adjust:100%}body{padding:0;margin:0;background:#f2f6fa;color:#3c495a;font-weight:normal;font-size:15px;font-family:'San Francisco','Roboto','Arial',sans-serif}h2,h3,h4,h5,h6{font-family:'Trebuchet MS',Verdana,sans-serif;color:#586b82;padding:0;margin:20px 0 10px 0;font-size:1.1em}h2{margin:30px 0 10px 0;font-size:1.2em}a{color:#3fa7ba;text-decoration:none}p{margin:6px 0;text-align:justify}ul,ol{margin:0;text-align:justify}ul>li>code{color:#586b82}pre{white-space:pre-wrap}#content{width:96%;max-width:1000px;margin:2% auto 6% auto;background:white;border-radius:2px;border-right:1px solid #e2e9f0;border-bottom:2px solid #e2e9f0;padding:0 115px 150px 115px;box-sizing:border-box}#postamble{display:none}h1.title{background-color:#343C44;color:#fff;margin:0 -115px;padding:60px 0;font-weight:normal;font-size:2em;border-top-left-radius:2px;border-top-right-radius:2px}@media (max-width: 1050px){#content{padding:0 70px 100px 70px}h1.title{margin:0 -70px}}@media (max-width: 800px){#content{width:100%;margin-top:0;margin-bottom:0;padding:0 4% 60px 4%}h1.title{margin:0 -5%;padding:40px 5%}}pre,.verse{box-shadow:none;background-color:#f9fbfd;border:1px solid #e2e9f0;color:#586b82;padding:10px;font-family:monospace;overflow:auto;margin:6px 0}#table-of-contents{margin-bottom:50px;margin-top:50px}#table-of-contents h2{margin-bottom:5px}#text-table-of-contents ul{padding-left:15px}#text-table-of-contents>ul{padding-left:0}#text-table-of-contents li{list-style-type:none}#text-table-of-contents a{color:#7c8ca1;font-size:0.95em;text-decoration:none}table{border-color:#586b82;font-size:0.95em}table thead{color:#586b82}table tbody tr:nth-child(even){background:#f9f9f9}table tbody tr:hover{background:#586b82!important;color:white}table .left{text-align:left}table .right{text-align:right}.todo{font-family:inherit;color:inherit}.done{color:inherit}.tag{background:initial}.tag>span{background-color:#eee;font-family:monospace;padding-left:7px;padding-right:7px;border-radius:2px;float:right;margin-left:5px}#text-table-of-contents .tag>span{float:none;margin-left:0}.timestamp{color:#7c8ca1}@media print{@page{margin-bottom:3cm;margin-top:3cm;margin-left:2cm;margin-right:2cm;font-size:10px}#content{border:none}}</style>")
  (setq org-html-validation-link nil)
  (setq org-html-creator-string ""))
