;;; init.el --- PaperMonoids configuration file.
;;; Commentary:
;;; PaperMonoids configuration file.
;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; Custom functions.
(defun insert-uuid ()
  "Generate a UUID using linux uuidgen command."
  ;; See also
  ;; http://ergoemacs.org/emacs/elisp_generate_uuid.html
  ;; http://ergoemacs.org/emacs/keyboard_shortcuts.html
  (interactive)
  (shell-command "uuidgen | head -c -1" t)
  (forward-char 36))
(global-set-key (kbd "<f1> u u i d") 'insert-uuid)

;; use-package autoload
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)

;; Configurations
(if (window-system)
    (progn (set-frame-width (selected-frame) 80)
	   (set-frame-height (selected-frame) 27)))
(set-frame-font "DejaVu Sans Mono Book 13")
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(fringe-mode 8)
(set-frame-parameter nil 'internal-border-width 0)
(setq-default bidi-display-reordering nil)
(global-hl-line-mode 1)
(setq-default cursor-type 'box)
(setq org-startup-with-inline-images t)
(setq my-backup-directory (concat user-emacs-directory "backup/"))
(setq my-auto-save-directory (concat user-emacs-directory "auto-save/"))
(unless (file-exists-p my-auto-save-directory)
  (make-directory my-auto-save-directory))
(setq backup-directory-alist
      `((".*" . ,my-backup-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,my-auto-save-directory t)))
(defun show-trailing-whitespace-mode ()
  "Show trailing space."
  (setq whitespace-line-column 80)
  (setq show-trailing-whitespace 1)
  (setq whitespace-style '(face lines-tail))
  (diminish 'whitespace-mode))
(add-hook 'prog-mode-hook 'show-trailing-whitespace-mode)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'show-paren-mode)
(add-hook 'emacs-startup-hook '(lambda () (message "Hello PaperMonoid!")))
(global-set-key (kbd "<S-return>") (kbd "<return> <return> C-p <tab>"))
(add-to-list 'auto-mode-alist '("\\.pro\\'" . prolog-mode))
(org-babel-do-load-languages
 'org-babel-load-languages '((shell . t)))

;; Looks
(use-package beacon
  :ensure t
  :diminish beacon-mode
  :config (beacon-mode))
(use-package powerline
  :ensure t
  :hook (emacs-startup . powerline-default-theme))
(use-package diminish
  :ensure t)
(use-package org-bullets
  :ensure t
  :hook org-mode)
(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :init (volatile-highlights-mode))
(use-package highlight-symbol
  :ensure t
  :diminish highlight-symbol-mode
  :hook (prog-mode . highlight-symbol-mode))
(use-package highlight-numbers
  :ensure t
  :hook (prog-mode . highlight-numbers-mode))
(use-package hl-todo
  :ensure t
  :hook (prog-mode . hl-todo-mode))

;; Navigation
(use-package avy
  :ensure t
  :bind
  ("C-:" . avy-goto-char)
  ("C-'" . avy-goto-char-2))
(use-package ace-window
  :ensure t
  :config (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("C-x o" . ace-window))
(use-package smart-forward
  :ensure t
  :bind
  ("M-<up>" . smart-up)
  ("M-<down>" . smart-down)
  ("M-<left>" . smart-backward)
  ("M-<right>" . smart-forward))

;; Programming modes
(use-package gnuplot-mode
  :ensure t)
(use-package ess
  :ensure t)
(use-package web-mode
  :ensure t
  :init
  (setq-default web-mode-indent-style 2)
  (setq-default web-mode-code-indent-offset 2)
  (setq-default web-mode-markup-indent-offset 2)
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.php\\'" . web-mode)
  ("\\.blade\\." . web-mode)
  ("\\.tsx\\'" . web-mode))
(use-package rjsx-mode
  :mode ("\\.js\\'" . js2-mode)
  :init
  (setq-default js-indent-level 2)
  (setq-default css-indent-offset 2)
  :ensure t)
(use-package typescript-mode
  :init
  (setq-default typescript-indent-level 2)
  :ensure t)
(use-package vue-mode
  :ensure t)
(use-package jedi
  :ensure t
  :hook (python-mode-hook . jedi:setup))
(use-package csharp-mode
  :ensure t)
(use-package haskell-mode
  :ensure t)
(use-package racket-mode
  :ensure t)
(use-package slime
  :ensure t
  :init
  (setq inferior-lisp-program "/bin/sbcl")
  (setq slime-contribs '(slime-fancy)))
(use-package clojure-mode
  :ensure t)
(use-package irony
  :ensure t)
(use-package arduino-mode
  :ensure t)
(use-package go-mode
  :ensure t)
(use-package scala-mode
  :ensure t)
(use-package kotlin-mode
  :ensure t)
(use-package groovy-mode
  :ensure t)
(use-package gradle-mode
  :ensure t)
(use-package json-mode
  :ensure t)
(use-package yaml-mode
  :ensure t)
(use-package csv-mode
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
(use-package tex
  :defer t)
(use-package edit-indirect
  :ensure t)

;; Tools
(use-package magit
  :ensure t)
(use-package flymd
  :init
  (setq-default flymd-output-directory "/tmp")
  :ensure t)
(use-package restclient
  :mode ("\\.http\\'" . restclient-mode)
  :ensure t)
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (setq-default helm-M-x-fuzzy-match t
  		helm-bookmark-show-location t
  		helm-buffers-fuzzy-matching t
  		helm-completion-in-region-fuzzy-match t
  		helm-file-cache-fuzzy-match t
  		helm-imenu-fuzzy-match t
  		helm-mode-fuzzy-match t
  		helm-locate-fuzzy-match t
  		helm-quick-update t
  		helm-recentf-fuzzy-match t
  		helm-semantic-fuzzy-match t)
  :bind
  ("M-x" . helm-M-x)
  ("C-x r b" . helm-filtered-bookmarks)
  ("C-x C-f" . helm-find-files)
  :config (helm-mode 1))
(use-package projectile
  :ensure t
  :config (projectile-mode 1))
(use-package helm-projectile
  :ensure t
  :bind ("C-c p h" . helm-projectile))
(use-package helm-swoop
  :ensure t
  :bind ("C-c C-s" . helm-swoop))

;; Programming
(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))
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
  :hook (prog-mode . smartparens-mode))
(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init (yas-global-mode))
(use-package yasnippet-snippets
  :ensure t)
(use-package slime-company
  :ensure t)
(use-package company
  :after yasnippet
  :ensure t
  :diminish company-mode
  :config
  ;; http://xuchengpeng.com/2018/04/27/emacs-add-yasnippet-to-company-backends/
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
	backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  :hook (prog-mode . company-mode))
(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))

;; Theme
(use-package solarized-theme
  :ensure t)
(use-package color-theme-solarized
  :ensure t)

;; Misc
(use-package lorem-ipsum
  :ensure t
  :config (lorem-ipsum-use-default-bindings))
(use-package toc-org
  :ensure t)
(use-package htmlize
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized)))
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default)))
 '(package-selected-packages
   (quote
    (vue-mode groovy-mode gradle-mode kotlin-mode color-theme-solarized htmlize diminish slime-company slime flycheck hl-todo highlight-numbers highlight-symbol yasnippet-snippets yaml-mode ws-butler web-mode volatile-highlights use-package typescript-mode smartparens smart-forward scala-mode rjsx-mode restclient racket-mode powerline org-bullets nginx-mode markdown-toc magit json-mode irony hungry-delete helm-swoop helm-projectile haskell-mode go-mode gnuplot-mode format-all flymd ess dockerfile-mode csharp-mode company beacon arduino-mode ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(delete-selection-mode 1)
;;; init.el ends here
