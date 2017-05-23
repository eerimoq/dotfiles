(show-paren-mode)

(setq-default c-basic-offset 4)

(add-to-list 'load-path "/home/erik/workspace/rust/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )

(setq-default fill-column 70)

(global-set-key [f5] 'refresh-file)

(global-set-key [f6] 'find-grep-c-source)

;; Configure flymake for Python
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '3)

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-c\C-n" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-c\C-p" 'flymake-goto-prev-error)))

(add-to-list 'auto-mode-alist '("\\.sconscript\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.SConscript\\'" . python-mode))
(add-to-list 'auto-mode-alist '("sconstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("SConstruct\\'" . python-mode))

;; To avoid having to mouse hover for the error message, these functions make flymake error messages
;; appear in the minibuffer
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the message in the minibuffer"
  (require 'cl)
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
      (let ((err (car (second elem))))
        (message "%s" (flymake-ler-text err)))))))

(add-hook 'post-command-hook 'show-fly-err-at-point)

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Switch buffer using iswitchb
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(iswitchb-mode t)
(autoload 'iswitchb "iswitchb" "Run iswitchb" t)
(setq read-buffer-function 'iswitchb-read-buffer)
(setq iswitchb-default-method 'samewindow) ;; Open buffer in the same window
(setq iswitchb-regexp t) ;; Enable usage of regular expressions in iswitchb

; Add folder name before filename if a file with the same name is already opened (i.e. Makefile)
(require 'uniquify)
(setq uniquify-buffer-name-style (quote forward))

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;hides the toolbar
(tool-bar-mode 0)

(setq grep-command "grep -n -i ")
(setq compile-command "make")

;; Show column-number in the mode line
(column-number-mode 1)

;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)

(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'arglist-intro '+)
            (c-set-offset 'arglist-close 0)))

;; Set cursor color
(set-cursor-color "red")

;; Set mouse color
(set-mouse-color "white")

;; Set foreground and background
(set-foreground-color "white")
(set-background-color "gray15")

;; Set highlighting colors for isearch and drag
(set-face-foreground 'highlight "white")
(set-face-background 'highlight "blue")

(set-face-foreground 'region "cyan")
(set-face-background 'region "blue")

(set-face-foreground 'secondary-selection "skyblue")
(set-face-background 'secondary-selection "darkblue")

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;; setup scroll mouse settings
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)
(global-set-key [s-up] 'down-one)
(global-set-key [s-down] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

;; mouse button one drags the scroll bar
(global-set-key [vertical-scroll-bar down-mouse-1] 'scroll-bar-drag)

;; extra key bindings
(global-set-key "\M-C" 'compile)
(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-,") 'select-previous-window)
(global-set-key [M-left] 'windmove-left)          ; move to left windnow
(global-set-key [M-right] 'windmove-right)        ; move to right window
(global-set-key [M-up] 'windmove-up)              ; move to upper window
(global-set-key [M-down] 'windmove-down)          ; move to downer window
