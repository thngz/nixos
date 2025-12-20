;; Initialize package sources

(require 'use-package)

(setq make-backup-files nil) ;; stop creating ~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(global-auto-revert-mode 1) ;; enables auto revert
;; (add-hook 'after-save-hook 'lsp-format-buffer)

;; Fix tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq auto-save-timeout 3)
    (setq auto-save-interval 20)
(scroll-bar-mode -1)
(tool-bar-mode -1) 
(set-fringe-mode 10)

(text-scale-increase 3)
(menu-bar-mode -1)
(setq inhibit-startup-message t) 


(setq visible-bell t) 

(setq global-hl-line-modes nil) 
(column-number-mode)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)


(set-face-attribute 'default nil :font "Iosevka" :height 256)

(use-package all-the-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(load-theme 'modus-vivendi)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Finders and stuff
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :init (setq completion-styles '(orderless)))

(use-package consult)

;; EVIL STUFF
(use-package evil
  :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
  :config
    (evil-mode 1)
    (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
    (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
    (evil-define-key 'normal 'global (kbd "<leader>ff") 'consult-find)
    (evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status)
    (evil-define-key 'normal 'global (kbd "<leader>h") 'evil-window-left)
    (evil-define-key 'normal 'global (kbd "<leader>j") 'evil-window-down)
    (evil-define-key 'normal 'global (kbd "<leader>k") 'evil-window-up)
    (evil-define-key 'normal 'global (kbd "<leader>l") 'evil-window-right)
    (evil-define-key 'normal 'global (kbd "gd") 'xref-find-definitions)
    (evil-define-key 'normal 'global (kbd "gD") 'eglot-find-declaration)
    (evil-define-key 'normal 'global (kbd "gi") 'eglot-find-implementation)
    (evil-define-key 'normal 'global (kbd "go") 'eglot-find-typeDefinition)
    (evil-define-key 'normal 'global (kbd "gr") 'xref-find-references)
    (evil-define-key 'normal 'global (kbd "<leader>ca") 'eglot-code-actions)
    (evil-define-key 'normal 'global (kbd "<leader>rn") 'eglot-rename)
    (evil-define-key 'normal 'global (kbd "<leader>vd") 'flymake-show-buffer-diagnostics)
    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
    (evil-set-leader nil (kbd "SPC"))
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal)
    (evil-set-initial-state 'bs-mode 'emacs)
    (evil-set-initial-state 'term-mode 'emacs))


(use-package evil-collection
 :after evil
 :config
 (evil-collection-init))

;; CODE STUFF
(use-package eglot
  :hook ((python-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (go-ts-mode . eglot-ensure)))

(use-package magit
    :commands (magit-status magit-get-current-branch)
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package eldoc-box
  :ensure t
  :hook (eglot-managed-mode . eldoc-box-hover-mode))

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

(use-package flycheck)
(global-flycheck-mode 1)

