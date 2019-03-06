
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/.emacs-saves"))))
 '(before-save-hook (quote (delete-trailing-whitespace)))
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(delete-old-versions t)
 '(git-commit-setup-hook
   (quote
    (git-commit-save-message git-commit-setup-changelog-support git-commit-turn-on-auto-fill git-commit-turn-on-flyspell git-commit-propertize-diff bug-reference-mode with-editor-usage-message)))
 '(gofmt-command "goimports")
 '(indent-tabs-mode nil)
 '(kept-new-versions 6)
 '(org-agenda-files (quote ("~/lumapps/lumapps.org")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (company-coq proof-general scala-mode terraform-mode ox-pandoc org-bullets haskell-mode helm-ls-git blacken spacemacs-theme helm helm-ag helm-org-rifle helm-ebdb ag groovy-mode yaml-mode clojure-mode go-mode markdown-mode markdown-mode+ markdown-toc php-mode magit)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(display-time)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "M-*") 'pop-tag-mark)
(add-hook 'markdown-mode-hook (lambda () (flyspell-mode )))

(require 'helm-config)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "M-x") #'helm-M-x)
(helm-mode t)

(add-hook 'python-mode-hook 'blacken-mode)
(add-to-list 'auto-mode-alist '("\\.jinja\\(\\.schema\\)\?\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("Jenkinsfile\\'" . groovy-mode))

(add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save nil t)))
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer."
  (interactive)
  (save-excursion
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indented selected region."))
      (progn
        (indent-buffer)
        (message "Indented buffer.")))))

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)
