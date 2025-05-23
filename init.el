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
(setq package-install-upgrade-built-in t)
(progn (unload-feature 'seq t) (require 'seq))


(defun setup/gui ()
  "Basic configuration to the GNU Emacs GUI."
  (add-hook 'prog-mode-hook 'linum-mode)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (fringe-mode 16)
  (global-hl-line-mode 1)
  (blink-cursor-mode 1)
  (set-frame-parameter nil 'internal-border-width 0)
  (set-frame-font "Comic Mono-17:antialias=true")
  (setq-default cursor-type 'bar)
  (setq-default org-startup-with-inline-images t)
  (global-so-long-mode 1)
  (load-file
   (concat user-emacs-directory
	   "themes/color-theme-espresso/espresso-theme.el"))
  (enable-theme 'espresso)
  (setq mac-command-modifier 'meta)
  (setq mac-right-option-modifier 'option))


(defun setup/autosave-lock-and-backup ()
  "Backup, lock, and autosave directories to prevent making files everywhere."
  (let ((backup-dir (expand-file-name "backup/"     user-emacs-directory))
        (autosave-dir (expand-file-name "autosave/"  user-emacs-directory))
        (lockfile-dir (expand-file-name "lockfiles/"  user-emacs-directory)))
    (dolist (dir (list backup-dir autosave-dir lockfile-dir))
      (make-directory dir :parents))
    ;; 1. backups  foo~
    (setq backup-directory-alist `(("." . ,backup-dir)))
    ;; 2. auto-saves  #foo#
    (setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))
    ;; 3. lock files  .#foo
    (setq lock-file-name-transforms `((".*" ,lockfile-dir t)))))


(defun setup/use-package ()
  "Setup the necesary tools to install all the required packages."
  (if (not (package-installed-p 'use-package))
      (progn
	(package-refresh-contents)
	(package-install 'use-package)))
  (require 'use-package))


(defun setup/look-and-feel ()
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
  (use-package telephone-line
    :ensure t
    :config (telephone-line-mode 1))
  (use-package flycheck
    :ensure t
    :config
    (add-hook 'after-init-hook #'global-flycheck-mode))
  (use-package swiper
    :ensure t)
  (use-package counsel
    :ensure t)
  (use-package ivy
    :diminish ivy-mode
    :ensure t
    :config
    (ivy-mode)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    ;; enable this if you want `swiper' to use it
    ;; (setq search-default-mode #'char-fold-to-regexp)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)))


(defun setup/programming ()
  "Progamming tools and languages modes."
  (use-package magit
    :ensure t)
  (use-package go-mode
    :ensure t)
  (use-package geiser
    :ensure t)
  (use-package geiser-chez
    :ensure t)
  (use-package haskell-mode
    :ensure t)
  (use-package json-mode
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
  (use-package nasm-mode
    :ensure t
    :mode ("\\.asm\\'" . nasm-mode))
  (use-package graphviz-dot-mode
    :ensure t)
  (use-package tex
    :defer t)
  (use-package string-inflection
    :ensure t
    :bind
    ("C-c i" . string-inflection-cycle)
    ("C-c C" . string-inflection-camelcase)
    ("C-c L" . string-inflection-lower-camelcase)
    ("C-c J" . string-inflection-java-style-cycle))
  (use-package hungry-delete
    :ensure t
    :diminish hungry-delete-mode
    :hook (prog-mode . hungry-delete-mode))
  (use-package expand-region
    :ensure t
    :bind ("C-=" . er/expand-region)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a4ea82553152f6910c9dcf306d8a7b63a2667d2f9aca9c07e3a8a3a018d5cf72" default))
 '(package-selected-packages
   '(telephone-line go-mode haskell-mode flycheck yaml-mode magit expand-region hungry-delete string-inflection graphviz-dot-mode nasm-mode markdown-mode nginx-mode dockerfile-mode csv json-mode highlight-numbers highlight-symbol volatile-highlights beacon diminish counsel swiper geiser-chez geiser use-package)))


(setup/gui)
(setup/autosave-lock-and-backup)
(setup/use-package)
(setup/look-and-feel)
(setup/programming)
(delete-selection-mode 1)
(load-file (concat user-emacs-directory "utils.el"))
;;; init.el ends here
