; https://gist.github.com/Gavinok/38975384c4a46c291103e7b220dc25e9#file-init-el

;;; Startup
;;; PACKAGE LIST
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(setq evil-search-module 'evil-search)
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package markdown-mode)

; Theme
(use-package night-owl-theme)
(load-theme 'night-owl t)

; ; Theme
; 
; (deftheme theme-base-16
;   "Color theme to use underlying terminal colors")
; 
; (let ((class '((class color) (min-colors 8))))
;   (custom-theme-set-faces
;    'theme-base-16
; 
;    ;normal stuff
;    `(default ((,class (:background "darkblack" :foreground "white"))))
;    `(cursor ((,class (:background "green" :forefround "green"))))
;    `(fringe ((,class (:background "none" :foreground "green"))))
; 
;    ; special stuff
;    `(font-lock-builtin-face ((,class (:foreground "blue"))))
;    `(font-lock-constant-face ((,class (:foreground "cyan"))))
;    `(font-lock-keyword-face ((,class (:foreground "blue"))))
;    `(font-lock-string-face ((,class (:foreground "cyan"))))
;    `(font-lock-comment-face ((,class (:foreground "green"))))
;    `(font-lock-warning-face ((,class (:foreground "red"))))
;    `(font-lock-type-face ((,class (:foreground "yellow"))))
;    `(font-lock-variable-name-face ((,class (:foreground "white"))))
;    `(font-lock-function-name-face ((,class (:foreground "white"))))
;    `(font-lock-constant-face ((,class (:foreground "cyan"))))
;    `(font-lock-warning-face ((,class (:foreground "red"))))))
; 
; (provide-theme 'theme-base-16)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(night-owl-theme use-package evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
