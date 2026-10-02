;;; -*- lexical-binding: t; coding: utf-8 -*-

;; ============================================================
;; 基础设置
;; ============================================================
(setq inhibit-startup-screen t)
(setq warning-suppress-types '((files)))

(setq mouse-highlight nil)
(setq inhibit-compacting-font-caches t)

(cua-mode 1)
(global-set-key (kbd "C-S-a") 'mark-whole-buffer)
(global-set-key (kbd "C-s") 'save-buffer)

(tool-bar-mode -1)
(setq-default cursor-type 'bar)

;; ============================================================
;; 包管理
;; ============================================================
(require 'package)
(setq package-archives '(("gnu"    . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.ustc.edu.cn/elpa/melpa/")))
(package-initialize)

;; 通用：确保包已安装
(defun my/ensure-package (pkg)
  (unless (package-installed-p pkg)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install pkg)))

(mapc #'my/ensure-package '(web-mode doom-themes vertico treemacs))

(custom-set-variables
 '(custom-safe-themes
   '("0325a6b5eea7e5febae709dab35ec8648908af12cf2d2b569bedc8da0a3a81c1"))
 '(package-selected-packages '(treemacs doom-themes vertico web-mode)))

;; ============================================================
;; web-mode / eglot
;; ============================================================
(require 'web-mode)
(require 'eglot)

;; ============================================================
;; 主题
;; ============================================================
(require 'doom-themes)
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)
(doom-themes-visual-bell-config)
(doom-themes-org-config)

;; ============================================================
;; vertico 补全
;; ============================================================
(require 'vertico)
(vertico-mode 1)

(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)

;; ============================================================
;; treemacs
;; ============================================================
(require 'treemacs)

(setq treemacs-position 'left)
(setq treemacs-width 30)
(setq treemacs-follow-mode t)
(setq treemacs-filewatch-mode nil)
(setq treemacs-git-mode nil)
(setq treemacs-show-icons nil)

;; --- 消除所有延迟 ---
(setq treemacs-file-event-delay 0)
(setq treemacs-deferred-git-apply-delay 0)
(setq treemacs-file-follow-delay 0)
(setq treemacs-tag-follow-delay 0)

;; --- 关键：关闭 Emacs 的双击识别等待 ---
(setq double-click-time nil)

;; 鼠标左键单击展开/折叠目录
(with-eval-after-load 'treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(treemacs-project-follow-mode 1)

(add-hook 'emacs-startup-hook #'treemacs)

;; ============================================================
;; 自动刷新
;; ============================================================
(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)
(setq auto-revert-interval 1)

;; ============================================================
;; desktop 会话
;; ============================================================
(require 'desktop)
(setq desktop-buffers-not-to-save
      (concat "\\*Treemacs\\|" desktop-buffers-not-to-save))
(desktop-save-mode 1)

;; ============================================================
;; 文件关联
;; ============================================================
(push '("\\.wxml\\'" . web-mode) auto-mode-alist)
(push '("\\.wxss\\'" . css-mode) auto-mode-alist)

(add-hook 'web-mode-hook
          (lambda ()
            (when (buffer-file-name)
              (eglot-ensure))))

(add-hook 'css-mode-hook
          (lambda ()
            (when (buffer-file-name)
              (eglot-ensure))))

;; ============================================================
;; eglot 语言服务器
;; ============================================================
(setf (alist-get 'web-mode eglot-server-programs)
      '("/home/linuxbrew/.linuxbrew/bin/wxml-langserver" "--stdio"))

(setf (alist-get 'css-mode eglot-server-programs)
      '("/home/linuxbrew/.linuxbrew/bin/vscode-css-language-server" "--stdio"))
