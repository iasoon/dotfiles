;; Space littering is bad
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Pls no
(setq inhibit-startup-screen t)

;; Git exists
(setq make-backup-files nil)

(setq scroll-preserve-screen-position t)

(require 'package)

;; Packages

(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq use-package-always-ensure t)

(use-package solarized-theme
  :init (load-theme 'solarized-light t))

(use-package helm
  :init   (helm-mode 1)
  :config
  (setq helm-split-window-in-side-p t)
  (setq helm-display-header-line nil)
  :bind
  (("M-x"     . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x b"   . helm-buffers-list)
   :map helm-map
   ("<tab>"   . helm-execute-persistent-action)
   ("C-s"     . helm-select-action)
   ("C-j"     . nil)
   ("C-z"     . nil)))

(setq display-buffer-alist nil)
(add-to-list 'display-buffer-alist
	     `(,(rx bos "*" (* nonl) "helm" (* nonl) "*" eos)
		 (display-buffer-in-side-window)
		 (inhibit-same-window . t)
		 (side . bottom)
		 (window-height . 0.2)))

(use-package projectile
  :init   (projectile-global-mode)
  :config
  (setq projectile-completion-system 'helm))

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package magit
  :bind
  (("C-c g s" . magit-status)
   ("C-c g c" . magit-commit-popup)
   ("C-c g d" . magit-diff)
   ("C-c g b" . magit-blame)
   ("C-c g l" . magit-log)))

(use-package company)

(use-package flycheck)

;; C programming
(use-package rtags
  :config
  (setq rtags-path (expand-file-name "~/src/rtags/bin")))

(use-package lispy
  :config
  ;; dvorak friendly bindings
  (mapc (lambda (bind) (lispy-define-key lispy-mode-map (car bind) (cdr bind)))
  	'(("h" . lispy-down)
  	  ("t" . lispy-up)
  	  ("n" . lispy-flow)
  	  ("d" . lispy-left)
	  ("s" . lispy-right)
	  ("o" . lispy-different)
	  ("H" . lispy-move-down)
	  ("T" . lispy-move-up))))

(use-package expand-region)

(use-package multiple-cursors)

(use-package which-key
  :init (which-key-mode)
  :config
  (which-key-declare-prefixes
    "C-c g" "git"))

(use-package undo-tree
  :init (global-undo-tree-mode))


(use-package clojure-mode)
(use-package cider)

(add-hook 'emacs-lisp-mode-hook 'lispy-mode)
(add-hook 'clojure-mode-hook 'lispy-mode)
