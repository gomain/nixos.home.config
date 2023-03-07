(setq backup-directory-alist '((".*" . "~/.emacs.d/backup-directory/")))

;; to use packages installed with nix-env
(require 'package)
(add-to-list 'package-directory-list "~/.nix-profile/share/emacs/site-lisp/elpa/")
;; (package-initialize)

;; for programs that have emacs support
(add-to-list 'load-path "~/.nix-profile/share/emacs/site-lisp/")

;; edit-server
(edit-server-start)

;; global settings

;; buffer names
(setq uniquify-buffer-name-style 'forward)
;; show line numbers everywhere, every mode
(setq line-number-mode t)
(setq column-number-mode t)
(global-display-line-numbers-mode)
;; input when selection replaces the selection
(delete-selection-mode 1)

;; spell checker
;;(add-hook 'text-mode-hook
;;          (lambda ()
;;            (flyspell-mode)))
;;(add-hook 'prog-mode-hook
;;          (lambda ()
;;            (flyspell-prog-mode)))
(add-hook 'flyspell-mode-hook
	  (lambda ()
	    (define-key flyspell-mode-map (kbd "M-TAB") #'flyspell-correct-at-point)))

;; global lsp-mode
;; this puts logs in `./.log`
;; (setq lsp-clients-typescript-log-verbosity "verbose")
(add-hook 'lsp-mode-hook
          (lambda ()
            (add-to-list 'lsp-disabled-clients 'jsts-ls)
            ;(setq lsp-clients-typescript-tls-path
            ;      "~/BIMLauncher/bim-connector/bimlauncher-connector/production/aconex-sdk/node_modules/.bin/typescript-language-server")
            (setq lsp-headerline-breadcrumb-enable t)))

;; graphviz-dot-mode
(add-hook 'graphviz-dot-mode-hook
          (lambda ()
            (setq graphviz-dot-indent-width 2)
            (company-mode)))

;; Lilypond-mode
(autoload 'LilyPond-mode "lilypond-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ly\\'" . LilyPond-mode))

(add-to-list 'auto-mode-alist '("\\.[sx]?html\\(\\.[a-zA-Z_]+\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[cm]?[jt]s\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . json-mode))

;; Customize web-mode
(defun my-web-mode-hook ()
  "Customize web-mode"
  (setq web-mode-markup-indent-offset 2)
  (setq-default indent-tabs-mode nil)
)

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; tern
;(add-to-list 'load-path "~/tern/emacs/")
;(autoload 'tern-mode "tern.el" nil t)
;(eval-after-load 'tern
;		 '(progn
;		    (require 'tern-auto-complete)
;		    (tern-ac-setup)))

;; set flycheck-javascript-eslint-executable to node_modules/.bin/eslint
(defun use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file 
		(or (buffer-file-name) default-directory)
		"node_modules"))
	 (eslint (and root
		      (expand-file-name "node_modules/.bin/eslint" root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))

;(add-hook 'flycheck-mode-hook 'use-eslint-from-node-modules)

;; Customize js2-mode
(defun my-js2-mode-hook ()
  "Customize js2-mode"
  (setq js2-mode-offset 2)
  (lsp)
  )

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(defun my-typescript-mode-hook ()
  "Customize typescript-mode"
  (lsp))

(add-hook 'typescript-mode-hook 'my-typescript-mode-hook)
  
;;; setup tide
;(defun setup-tide-mode ()
;  (interactive)
;  (tide-setup)
;  (flycheck-mode +1)
;  (setq flycheck-chepck-syntax-automatically '(save mode-enabled))
;  (eldoc-mode +1)
;  (tide-hl-identifier-mode +1)
;  (company-mode +1))

(setq company-tooltip-align-annotations t)

;(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; setup purscript
;; local purescript-mode is outdated
;; (add-to-list 'load-path "~/purescript-mode/")
;; (require 'purescript-mode-autoloads)
;; (add-to-list 'Info-default-directory-list "~/purescript-mode/")
;;
;; ;; (require 'psc-ide)
;; (add-hook 'purescript-mode-hook
;;           (lambda ()
;;             (psc-ide-mode)
;;             (company-mode)
;;             (flycheck-mode)
;;             (turn-on-purescript-indentation)))

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
 '(flycheck-checker-error-threshold 5000)
 '(flycheck-checkers
   '(lsp ada-gnat asciidoctor asciidoc awk-gawk bazel-buildifier c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint css-stylelint cuda-nvcc cwl d-dmd dockerfile-hadolint elixir-credo emacs-lisp emacs-lisp-checkdoc ember-template erlang-rebar3 erlang eruby-erubis eruby-ruumba fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck go-unconvert go-staticcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy javascript-eslint javascript-jshint javascript-standard json-jsonlint json-python-json json-jq jsonnet less less-stylelint llvm-llc lua-luacheck lua markdown-markdownlint-cli markdown-mdl nix nix-linter opam perl perl-perlcritic php php-phpmd php-phpcs processing proselint protobuf-protoc protobuf-prototool pug puppet-parser puppet-lint python-flake8 python-pylint python-pycompile python-mypy r-lintr racket rpm-rpmlint rst-sphinx rst ruby-rubocop ruby-standard ruby-reek ruby-rubylint ruby ruby-jruby rust-cargo rust rust-clippy scala scala-scalastyle scheme-chicken scss-lint scss-stylelint sass/scss-sass-lint sass scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim slim-lint sql-sqlint systemd-analyze tcl-nagelfar terraform terraform-tflint tex-chktex tex-lacheck texinfo textlint typescript-tslint verilog-verilator vhdl-ghdl xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby yaml-yamllint rustic-clippy))
 '(flycheck-eslint-args '("--no-eslintrc tooling/.eslintrc.js"))
 '(flycheck-eslint-rules-directories nil)
 '(flycheck-navigation-minimum-level 'error)
 '(flycheck-typescript-tslint-executable nil)
 '(inferior-lisp-program "sbcl")
 '(js-indent-align-list-continuation nil)
 '(js-indent-level 2)
 '(rustic-lsp-server 'rust-analyzer)
 '(show-paren-mode t)
 '(tide-format-options '(indentSize 1 baseIndentSize 1 tabSize 1))
 '(typescript-indent-level 2)
 '(web-mode-code-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Terminus" :foundry "xos4" :slant normal :weight normal :height 105 :width normal)))))
(put 'upcase-region 'disabled nil)
