;;; -*- lexical-binding: t -*-

(setq inhibit-startup-screen t)
(setq warning-suppress-types '((files)))

(setq mouse-highlight nil)
(setq inhibit-compacting-font-caches t)

(cua-mode 1)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-s") 'save-buffer)

(tool-bar-mode -1)
(setq-default cursor-type 'bar)

(require 'package)
(setq package-archives '(("gnu"    . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.ustc.edu.cn/elpa/melpa/")))
(package-initialize)

(custom-set-variables
 '(custom-safe-themes
   '("0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"
     default))
 '(package-selected-packages '(treemacs doom-themes vertico)))

(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)
(doom-themes-visual-bell-config)
(doom-themes-org-config)

(require 'vertico)
(vertico-mode 1)

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

(require 'treemacs)

(setq treemacs-position 'left)
(setq treemacs-width 30)
(setq treemacs-follow-mode t)
(setq treemacs-filewatch-mode nil)
(setq treemacs-git-mode nil)
(setq treemacs-file-event-delay 100)
(setq treemacs-show-icons nil)

(treemacs-project-follow-mode 1)

(add-hook 'emacs-startup-hook #'treemacs)

(require 'desktop)
(setq desktop-buffers-not-to-save
      (concat "\\*Treemacs\\|" desktop-buffers-not-to-save))
(desktop-save-mode 1)
