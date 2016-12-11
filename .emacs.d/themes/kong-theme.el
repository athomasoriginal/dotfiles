;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom theme
;; everything in here is taken from https://github.com/hlissner/emacs-doom-theme/


(deftheme kong
  "Kong default theme - dark")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom groups

(defgroup kong-themes nil
  "Options for kong-themes"
  :group 'faces)

(defcustom kong-enable-bold t
  "If nil, bold will remove removed from all faces."
  :group 'kong-themes
  :type  'boolean)

(defcustom kong-enable-italic t
  "If nil, italics will remove removed from all faces."
  :group 'kong-themes
  :type  'boolean)

(defcustom kong-enable-brighter-comments nil
  "If non-nil, comments are brighter and easier to see."
  :group 'kong-themes
  :type  'boolean)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color helper functions

(defun kong-name-to-rgb (color &optional frame)
  (mapcar (lambda (x) (/ x (float (car (color-values "#ffffff")))))
          (color-values color frame)))

(defun kong-blend (color1 color2 alpha)
  (apply (lambda (r g b) (format "#%02x%02x%02x" (* r 255) (* g 255) (* b 255)))
         (--zip-with (+ (* alpha it) (* other (- 1 alpha)))
                     (kong-name-to-rgb color1)
                     (kong-name-to-rgb color2))))

(defun kong-lighten (color alpha)
  (kong-blend color "#FFFFFF" (- 1 alpha)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color settings
(let ((c '((class color) (min-colors 89)))
      (bold   kong-enable-bold)
      (italic kong-enable-italic)

      (black          "#181e26")
      (white          "#DFDFDF")
      (grey           (if window-system "#5B6268" "#525252"))
      (grey-d         "#3D3D48")
      (grey-dd        "#404850")
      (yellow         "#ECBE7B")
      (yellow-d       "#CDB464")
      (orange         "#da8548")
      (red            "#ff6c6b")
      (magenta        "#c678dd")
      (violet         "#a9a1e1")
      (cyan           "#46D9FF")
      (cyan-d         "#5699AF")
      (teal           "#4db5bd")
      (blue           "#51afef")
      (blue-d         "#1f5582")
      (green          "#98be65"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color assignments
  (let* ((bg             "#282c34")
         (bg-d           (if window-system "#22252c" "#222222"))
         (fg             "#bbc2cf")

         (highlight      blue)
         (vertical-bar   black)
         (current-line   (if window-system "#23272e" "#262626"))
         (selection      blue-d)
         (builtin        magenta)
         (comments       (if kong-enable-brighter-comments cyan-d grey))
         (doc-comments   (if kong-enable-brighter-comments teal (kong-lighten grey 0.2)))
         (constants      violet)
         (functions      magenta)
         (keywords       blue)
         (methods        cyan)
         (operators      blue)
         (type           yellow)
         (strings        green)
         (variables      white)
         (numbers        orange)
         (region         "#3d4451")

         ;; tabs
         (tab-unfocused-bg "#353a42")
         (tab-unfocused-fg "#1e2022")

         ;; main search regions
         (search-bg      blue)
         (search-fg      black)

         ;; other search regions
         (search-rest-bg grey-d)
         (search-rest-fg blue)

         ;; line number column
         (linum-bg       bg-d)
         (linum-fg       (if window-system grey-dd grey))
         (linum-hl-fg    "#BBBBBB")
         (linum-hl-bg    bg-d)

         ;; mode line
         (modeline-fg    fg)
         (modeline-fg-l  blue)
         (modeline-bg    (if window-system bg-d current-line))
         (modeline-bg-l  (if window-system blue current-line))
         (modeline-fg-inactive grey)
         (modeline-bg-inactive (if window-system bg-d current-line))

         ;; vcs
         (vc-modified    yellow-d)
         (vc-added       green)
         (vc-deleted     red))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; start implementing the theme here
    (custom-theme-set-faces
      'kong

      ;; Base
      `(bold                   ((,c (:weight ,(if bold 'bold 'normal) :color ,white))))
      `(italic                 ((,c (:slant  ,(if italic 'italic 'normal)))))
      `(bold-italic            ((,c (:weight ,(if bold 'bold 'normal) :slant ,(if italic 'italic 'normal) :foreground ,white))))

      ;; Global
      `(default                ((,c (:background ,bg-d :foreground ,fg))))
      `(fringe                 ((,c (:inherit default :foreground ,comments))))  ; thinish line to the left + right of buffer window
      `(region                 ((,c (:background ,region))))
      `(highlight              ((,c (:background ,blue :foreground ,black))))
      `(hl-line                ((,c (:background ,bg))))
      `(cursor                 ((,c (:background ,blue))))  ; literally, the cursors color
      `(shadow                 ((,c (:foreground ,grey))))
      `(minibuffer-prompt      ((,c (:foreground ,blue))))  ; cursor in the console at the bottom of the screen
      `(tooltip                ((,c (:background ,black :foreground ,fg))))
      `(error                  ((,c (:foreground ,red))))
      `(warning                ((,c (:foreground ,yellow))))
      `(success                ((,c (:foreground ,green))))
      `(secondary-selection    ((,c (:background ,blue :foreground ,black))))
      `(lazy-highlight         ((,c (:background ,blue-d :foreground ,white))))
      `(match                  ((,c (:foreground ,green :background ,black :bold ,bold))))
      `(trailing-whitespace    ((,c (:background ,doc-comments))))
      `(vertical-border        ((,c (:foreground ,vertical-bar :background ,vertical-bar))))
      `(show-paren-match       ((,c (:foreground ,red :bold ,bold))))
      `(linum
       ((((type graphic)) :background ,bg-d :foreground ,grey-dd :bold nil)
        (t                :background ,bg-d :foreground ,grey :bold nil)))

      `(font-lock-builtin-face           ((,c (:foreground ,builtin))))
      `(font-lock-comment-face           ((,c (:foreground ,comments))))
      `(font-lock-comment-delimiter-face ((,c (:foreground ,comments))))
      `(font-lock-doc-face               ((,c (:foreground ,doc-comments))))
      `(font-lock-doc-string-face        ((,c (:foreground ,doc-comments))))
      `(font-lock-constant-face          ((,c (:foreground ,constants))))
      `(font-lock-function-name-face     ((,c (:foreground ,functions))))
      `(font-lock-keyword-face           ((,c (:foreground ,keywords))))
      `(font-lock-string-face            ((,c (:foreground ,strings))))
      `(font-lock-type-face              ((,c (:foreground ,type))))
      `(font-lock-variable-name-face     ((,c (:foreground ,variables))))
      `(font-lock-warning-face           ((,c (:inherit warning))))
      `(font-lock-negation-char-face          ((,c (:foreground ,operators :bold ,bold))))
      `(font-lock-preprocessor-face           ((,c (:foreground ,operators :bold ,bold))))
      `(font-lock-preprocessor-char-face      ((,c (:foreground ,operators :bold ,bold))))
      `(font-lock-regexp-grouping-backslash   ((,c (:foreground ,operators :bold ,bold))))
      `(font-lock-regexp-grouping-construct   ((,c (:foreground ,operators :bold ,bold))))

      ;; Modeline
      `(mode-line                   ((,c (:foreground ,modeline-fg          :background ,modeline-bg))))
      `(mode-line-inactive          ((,c (:foreground ,modeline-fg-inactive :background ,modeline-bg-inactive))))
      `(header-line                 ((,c (:inherit mode-line))))

      ;; ?????
      `(kong-modeline-buffer-path       ((,c (:foreground ,(if bold white cyan) :bold ,bold))))
      `(doom-modeline-buffer-project    ((,c (:foreground ,fg))))
      `(doom-modeline-buffer-modified   ((,c (:foreground ,red))))
      `(doom-modeline-buffer-major-mode ((,c (:foreground ,(if bold white blue) :bold ,bold))))

      `(doom-modeline-highlight     ((,c (:foreground ,blue))))
      `(doom-modeline-panel         ((,c (:foreground ,black :background ,blue))))
      `(doom-modeline-bar           ((,c (:background ,blue))))
      `(doom-modeline-eldoc-bar     ((,c (:background ,yellow))))

      ;; Powerline/Spaceline
      `(spaceline-highlight-face    ((,c (:foreground ,blue))))
      `(powerline-active1           ((,c (:inherit mode-line))))
      `(powerline-active2           ((,c (:inherit mode-line))))
      `(powerline-inactive1         ((,c (:inherit mode-line-inactive))))
      `(powerline-inactive2         ((,c (:inherit mode-line-inactive))))

      ;; `window-divider'
      `(window-divider              ((,c (:foreground ,vertical-bar))))
      `(window-divider-first-pixel  ((,c (:foreground ,vertical-bar))))
      `(window-divider-last-pixel   ((,c (:foreground ,vertical-bar))))

      ;; Helm
      `(helm-selection              ((,c (:background ,selection))))  ; the background highlight of the entire line
      `(helm-match                  ((,c (:foreground ,blue :underline t))))
      `(helm-source-header          ((,c (:background ,current-line :foreground ,grey)))) ; the background for each secton - see buffers
      `(helm-swoop-target-line-face ((,c (:foreground ,highlight :inverse-video t))))
      `(helm-ff-file                ((,c (:foreground ,fg))))
      `(helm-ff-prefix              ((,c (:foreground ,magenta))))
      `(helm-ff-dotted-directory    ((,c (:foreground ,grey-d))))
      `(helm-ff-directory           ((,c (:foreground ,orange))))
      `(helm-ff-executable          ((,c (:foreground ,white :slant italic))))

      ;; which-key
      `(which-key-key-face                   ((,c (:foreground ,green))))   ; the key is highlighted in green
      `(which-key-group-description-face     ((,c (:foreground ,violet))))  ;
      `(which-key-command-description-face   ((,c (:foreground ,blue))))    ; description is in blue
      `(which-key-local-map-description-face ((,c (:foreground ,magenta)))) ;

      ;; whitespace
      `(whitespace-tab              ((,c (:foreground ,grey-d))))
      `(whitespace-newline          ((,c (:foreground ,grey-d))))
      `(whitespace-trailing         ((,c (:background ,grey-d))))
      `(whitespace-line             ((,c (:background ,current-line :foreground ,magenta))))

      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; specify function variables
    (custom-theme-set-variables
     'kong
     `(vc-annotate-color-map
       '((20 .  ,green)
         (40 .  ,(kong-blend yellow green (/ 1.0 3)))
         (60 .  ,(kong-blend yellow green (/ 2.0 3)))
         (80 .  ,yellow)
         (100 . ,(kong-blend orange yellow (/ 1.0 3)))
         (120 . ,(kong-blend orange yellow (/ 2.0 3)))
         (140 . ,orange)
         (160 . ,(kong-blend magenta orange (/ 1.0 3)))
         (180 . ,(kong-blend magenta orange (/ 2.0 3)))
         (200 . ,magenta)
         (220 . ,(kong-blend red magenta (/ 1.0 3)))
         (240 . ,(kong-blend red magenta (/ 2.0 3)))
         (260 . ,red)
         (280 . ,(kong-blend grey red (/ 1.0 4)))
         (300 . ,(kong-blend grey red (/ 2.0 4)))
         (320 . ,(kong-blend grey red (/ 3.0 4)))
         (340 . ,grey)
         (360 . ,grey)))
     `(vc-annotate-very-old-color nil)
     `(vc-annotate-background ,black))

))

;;; ###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'kong)
