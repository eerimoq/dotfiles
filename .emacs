(set-background-color "gray5")
(set-foreground-color "white")

(show-paren-mode)

(setq-default indent-tabs-mode nil)

(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  )

(global-set-key [f5] 'refresh-file)