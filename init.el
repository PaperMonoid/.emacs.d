;;; init.el --- PaperMonoids configuration file.
;;; Commentary:
;;; PaperMonoids configuration file.
;;;
;;; Code:
(require 'package)
(add-to-list
 'package-archives
 '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


(defun setup/gui ()
  "Basic configuration to the GNU Emacs GUI."
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (fringe-mode 8)
  (global-hl-line-mode 1)
  (blink-cursor-mode 1)
  (set-frame-parameter nil 'internal-border-width 0)
  (set-frame-font "Monofur-16:antialias=true")
  (setq-default cursor-type 'bar)
  (setq-default org-startup-with-inline-images t)
  (load-file (concat user-emacs-directory "themes/color-theme-espresso/espresso-theme.el"))
  (enable-theme 'espresso)
  (global-so-long-mode 1))


(defun setup/autosave-and-backup ()
  "Backup and autosave directories to prevent making files everywhere."
  (setq-default backup-directory
		(concat user-emacs-directory "backup/"))
  (setq-default auto-save-directory
		(concat user-emacs-directory "auto-save/"))
  (unless (file-exists-p auto-save-directory)
    (make-directory auto-save-directory))
  (setq backup-directory-alist
	`((".*" . ,backup-directory)))
  (setq auto-save-file-name-transforms
	`((".*" ,auto-save-directory t))))


(defun setup/use-package ()
  "Setup the necesary tools to install all the required packages."
  (if (not (package-installed-p 'use-package))
      (progn
	(package-refresh-contents)
	(package-install 'use-package)))
  (require 'use-package))


(defun setup/look ()
  "Look and feel of the editor."
  (use-package diminish
    :ensure t)
  (use-package beacon
    :ensure t
    :diminish beacon-mode
    :config
    (beacon-mode)
    (setq beacon-blink-duration 0.625))
  (use-package volatile-highlights
    :ensure t
    :diminish volatile-highlights-mode
    :config (volatile-highlights-mode))
  (use-package highlight-symbol
    :ensure t
    :diminish highlight-symbol-mode
    :hook (prog-mode . highlight-symbol-mode))
  (use-package highlight-numbers
    :ensure t
    :diminish highlight-numbers-mode
    :hook (prog-mode . highlight-numbers-mode))
  (use-package hl-todo
    :ensure t
    :diminish hl-todo-mode
    :hook (prog-mode . hl-todo-mode)))


(defun setup/completion ()
  "Syntax checking, code completion and helm."
  (use-package flycheck
    :ensure t
    :diminish 'flycheck-mode
    :hook (prog-mode . flycheck-mode)
    :config
    (setq flycheck-python-pycompile-executable "python"))
  (use-package company
    :ensure t
    :diminish company-mode
    :init
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 1)
    :hook (prog-mode . company-mode))
  (use-package helm
    :ensure t
    :diminish helm-mode
    :config
    (global-set-key (kbd "M-x") #'helm-M-x)
    (global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
    (global-set-key (kbd "C-x C-f") #'helm-find-files)
    (helm-mode 1)))


(defun setup/programming ()
  "Progamming tools and languages modes."
  (use-package geiser
    :ensure t)
  (use-package geiser-chez
    :ensure t)
  (use-package haskell-mode
    :ensure t)
  (use-package json-mode
    :ensure t)
  (use-package js2-mode
    :ensure t)
  (use-package yaml-mode
    :ensure t)
  (use-package csv
    :ensure t)
  (use-package dockerfile-mode
    :ensure t)
  (use-package nginx-mode
    :ensure t)
  (use-package markdown-mode
    :ensure t)
  (use-package markdown-toc
    :ensure t)
  (use-package nasm-mode
    :ensure t
    :mode ("\\.asm\\'" . nasm-mode))
  (use-package graphviz-dot-mode
    :ensure t)
  (use-package tex
    :defer t)
  (use-package edit-indirect
    :ensure t)
  (use-package string-inflection
    :ensure t
    :bind
    ("C-c i" . string-inflection-cycle)
    ("C-c C" . string-inflection-camelcase)
    ("C-c L" . string-inflection-lower-camelcase)
    ("C-c J" . string-inflection-java-style-cycle))
  (use-package ws-butler
    :ensure t
    :diminish ws-butler-mode
    :hook (prog-mode . ws-butler-mode))
  (use-package hungry-delete
    :ensure t
    :diminish hungry-delete-mode
    :hook (prog-mode . hungry-delete-mode))
  (use-package format-all ;; this mode rocks
    :ensure t
    :diminish format-all-mode
    :hook (prog-mode . format-all-mode))
  (use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :hook (prog-mode . smartparens-mode)
    :config
    (sp-local-pair '(scheme-mode) "'" "'" :actions nil)
    (sp-local-pair '(scheme-mode) "`" "`" :actions nil)
    (sp-local-pair '(lisp-mode) "'" "'" :actions nil)
    (sp-local-pair '(lisp-mode) "`" "`" :actions nil)
    (sp-local-pair '(emacs-lisp-mode) "'" "'" :actions nil)
    (sp-local-pair '(emacs-lisp-mode) "`" "`" :actions nil))
  (use-package expand-region
    :ensure t
    :bind ("C-=" . er/expand-region)))


(defun setup/programming-hooks ()
  (add-hook
   'python-mode-hook
   (lambda () (setq-default format-all-formatters '(("Python" black))))))


(setup/gui)
(setup/autosave-and-backup)
(setup/use-package)
(setup/look)
(setup/completion)
(setup/programming)
(setup/programming-hooks)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(highlight-indent-guides beacon use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(delete-selection-mode 1)
;;; init.el ends here
