
;; to use packages installed with nix-env
(require 'package)
(add-to-list 'package-directory-list "~/.nix-profile/share/emacs/site-lisp/elpa/")
;; (package-initialize)


(setq uniquify-buffer-name-style 'forward)

(setq line-number-mode t)
(setq column-number-mode t)

(delete-selection-mode 1)

(add-to-list 'auto-mode-alist '("\\.[sx]?html\\(\\.[a-zA-Z_]+\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;; Customize web-mode
(defun my-web-mode-hook ()
  "Customize web-mode"
  (setq web-mode-markup-indent-offset 2)
  (setq-default indent-tabs-mode nil)
)

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; tern
(add-to-list 'load-path "~/tern/emacs/")
(autoload 'tern-mode "tern.el" nil t)
(eval-after-load 'tern
		 '(progn
		    (require 'tern-auto-complete)
		    (tern-ac-setup)))

;; set flycheck-javascript-eslint-executable to node_modules/.bin/eslint
(defun use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file 
		(or (buffer-file-name) default-directory)
		"node_modules"))
	 (eslint (and root
		      (expand-file-name "node_modules/.bin/eslint" root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

(add-hook 'flycheck-mode-hook 'use-eslint-from-node-modules)

(add-hook 'js-mode-hook (lambda ()
			  (tern-mode t)
			  (auto-complete-mode t)
			  (flycheck-mode t)))

;; Customize js2-mode
(defun my-js2-mode-hook ()
  "Customize js2-mode"
  (setq js2-mode-offset 2)
  )

(add-hook 'js2-mode 'my-js2-mode-hook)

;; setup tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; setup purscript
;; (require 'psc-ide)
(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (company-mode)
            (flycheck-mode)
            (turn-on-purescript-indentation)))

;; global configurations
(setq max-lisp-eval-depth 2000)
(global-auto-revert-mode)
(setq-default indent-tabs-mode nil)
(setq show-paren-delay 0)
(show-paren-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(js-indent-align-list-continuation nil)
 '(js-indent-level 2)
 '(show-paren-mode t)
 '(web-mode-code-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminus" :foundry "xos4" :slant normal :weight normal :height 105 :width normal)))))
(put 'upcase-region 'disabled nil)
