(require 'package)
(add-to-list 'package-archives
				'("melpa" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(add-to-list 'package-pinned-packages '("gnu-elpa-keyring-update" . "gnu"))
(unless (package-installed-p 'gnu-elpa-keyring-update)
		(defvar package-check-signature-default package-check-signature)
		(setq package-check-signature nil)
		(package-refresh-contents)
		(package-install 'gnu-elpa-keyring-update t)
		(setq package-check-signature package-check-signature-default))

(setq package-selected-packages '(lsp-mode lsp-treemacs lsp-ivy dap-mode which-key flycheck rust-mode yasnippet lsp-pyright))
(when (cl-find-if-not #'package-installed-p package-selected-packages)
	(mapc #'package-install package-selected-packages))

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'rust-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
		read-process-output-max (* 1024 1024)
		treemacs-space-between-root-nodes nil
		company-idle-delay 0.0
		company-minimum-prefix-length 1
		lsp-idle-delay 0.1) ;; clangd is fast

(with-eval-after-load 'lsp-mode
	(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
	(require 'dap-cpptools)
	(yas-global-mode))
