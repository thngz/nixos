(require 'use-package)

(setq make-backup-files nil) ;; stop creating ~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(global-auto-revert-mode 1) ;; enables auto revert
;; (add-hook 'after-save-hook 'lsp-format-buffer)

;; Fix tabs
(setq-default indent-tabs-mode nil)   ;; use spaces
(setq-default tab-width 4)            ;; tab display width
(setq-default indent-line-function 'indent-relative)  ;; normal indentation

(scroll-bar-mode -1)
(tool-bar-mode -1) 
(set-fringe-mode 10)

(text-scale-increase 3)
(menu-bar-mode -1)
(setq inhibit-startup-message t) 


(setq visible-bell -1) 

(setq global-hl-line-modes nil) 
(column-number-mode)

(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Looks
(set-face-attribute 'default nil :font "Iosevka-20")

(load-theme 'modus-vivendi)

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
    (evil-define-key 'normal 'global (kbd "<leader>fo") 'consult-ripgrep)

    (evil-define-key 'normal 'global (kbd "<leader>gs") 'magit-status)

    (evil-define-key 'normal 'global (kbd "<leader>h") 'evil-window-left)
    (evil-define-key 'normal 'global (kbd "<leader>j") 'evil-window-down)
    (evil-define-key 'normal 'global (kbd "<leader>k") 'evil-window-up)
    (evil-define-key 'normal 'global (kbd "<leader>l") 'evil-window-right)
    (evil-define-key 'normal 'global (kbd "<leader>q") 'delete-window)
    (evil-define-key 'normal 'global (kbd "<leader>sr") #'split-window-right)

    (evil-define-key 'normal 'global (kbd "gd") 'xref-find-definitions)
    (evil-define-key 'normal 'global (kbd "gD") 'eglot-find-declaration)
    (evil-define-key 'normal 'global (kbd "gi") 'eglot-find-implementation)
    (evil-define-key 'normal 'global (kbd "go") 'eglot-find-typeDefinition)
    (evil-define-key 'normal 'global (kbd "gr") 'xref-find-references)
    (evil-define-key 'normal 'global (kbd "K") 'eldoc-box-help-at-point)
    (evil-define-key 'normal 'global (kbd "<leader>ca") 'eglot-code-actions)
    (evil-define-key 'normal 'global (kbd "<leader>rn") 'eglot-rename)
    (evil-define-key 'normal 'global (kbd "<leader>vd") 'flymake-show-buffer-diagnostics)

    (evil-define-key 'normal 'global (kbd "s") 'avy-goto-char-timer)
    (evil-define-key 'normal 'global (kbd "S") 'evil-avy-goto-word-1)
    (evil-define-key 'normal 'global (kbd "gl") 'evil-avy-goto-line)


    (evil-global-set-key 'motion "j" 'evil-next-visual-line)
    (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
    (evil-set-leader nil (kbd "SPC"))
    (evil-set-initial-state 'messages-buffer-mode 'normal)
    (evil-set-initial-state 'dashboard-mode 'normal)
    (evil-set-initial-state 'bs-mode 'emacs))

(use-package avy
  :config
  (setq avy-timeout-seconds 0.2
        avy-style 'at-full))


(use-package evil-collection :after evil :config (evil-collection-init))

;; CODE STUFF



(use-package eglot
  :defer t
  :hook ((python-mode . eglot-ensure)
         (go-mode . eglot-ensure)))

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))


(use-package company-box
  :hook (company-mode . company-box-mode))

(global-company-mode 1)
(electric-pair-mode 1)
(use-package magit
    :commands (magit-status magit-get-current-branch)
    :custom
    (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package eldoc-box :ensure t)

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

(use-package flycheck)
(global-flycheck-mode 1)

