(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
;;evil mode package
(unless (package-installed-p 'evil)
  (package-install 'evil))


(require 'evil)
(evil-mode 1)
;;**********************************
;;lsp mode
(unless (package-installed-p 'lsp-mode)
  (package-refresh-contents)
  (package-install 'lsp-mode))

(unless (package-installed-p 'lsp-ui)
  (package-refresh-contents)
  (package-install 'lsp-ui))

(unless (package-installed-p 'typescript-mode)
  (package-refresh-contents)
  (package-install 'typescript-mode))

(unless (package-installed-p 'web-mode)
  (package-refresh-contents)
  (package-install 'web-mode))

(require 'lsp-mode)
(require 'lsp-ui)
(require 'typescript-mode)
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (lsp))))

(add-hook 'js-mode-hook #'lsp)
(add-hook 'js-jsx-mode-hook #'lsp)

(add-hook 'lsp-mode-hook #'lsp-ui-mode)

(setq lsp-semantic-tokens-enable t)



;;****************************************

;; Install company for autocomplete
(unless (package-installed-p 'company)
  (package-refresh-contents)
  (package-install 'company))

(require 'company)
(add-hook 'lsp-mode-hook #'company-mode)
(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 1)
;;****************************************

;;linting
(unless (package-installed-p 'flycheck)
  (package-refresh-contents)
  (package-install 'flycheck))

(require 'flycheck)

(add-hook 'lsp-mode-hook #'flycheck-mode)
;;****************************************



;;default settings
(global-display-line-numbers-mode t)
(setq make-backup-files nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(load-theme 'manoj-dark)
;;******************************************

;;vertico
(unless (package-installed-p 'vertico)
  (package-refresh-contents)
  (package-install 'vertico))

(unless (package-installed-p 'orderless)
  (package-refresh-contents)
  (package-install 'orderless))

(unless (package-installed-p 'consult)
  (package-refresh-contents)
  (package-install 'consult))

(require 'vertico)
(vertico-mode 1)

(require 'orderless)
(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion))))

(require 'consult)
;;******************************************


;;vterm
;;(unless (package-installed-p 'vterm)
 ;; (package-refresh-contents)
 ;; (package-install 'vterm))

;;(require 'vterm)
;;******************************************


;;clear space command
(evil-define-key 'normal 'global (kbd "SPC") nil)

;;key-maps
(define-prefix-command 'space-key-map)
(define-prefix-command 'window-key-map)
(define-prefix-command 'buffer-key-map)



(evil-define-key 'normal 'global (kbd "SPC") 'space-key-map)

;;space keymap
(define-key space-key-map (kbd ".") 'consult-find)
(define-key space-key-map (kbd "'") (lambda () (interactive) (ansi-term "/bin/bash")))
(define-key space-key-map (kbd "w") 'window-key-map)
(define-key space-key-map (kbd "b") 'buffer-key-map)

;;window keymap
(define-key window-key-map (kbd "h") 'windmove-left)
(define-key window-key-map (kbd "k") 'windmove-up)
(define-key window-key-map (kbd "j") 'windmove-down)
(define-key window-key-map (kbd "l") 'windmove-right)
(define-key window-key-map (kbd "s") 'split-window-below)
(define-key window-key-map (kbd "v") 'split-window-right)
(define-key window-key-map (kbd "d") 'delete-window)



;;buffer keymap
(define-key buffer-key-map (kbd "b") 'switch-to-buffer)
(define-key buffer-key-map (kbd "i") 'ibuffer)
(define-key buffer-key-map (kbd "r") 'rename-buffer)
(define-key buffer-key-map (kbd "e") 'eval-buffer)
(define-key buffer-key-map (kbd "d") 'kill-buffer)











(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(web-mode typescript-mode consult orderless helm flycheck company lsp-ui lsp-mode evil))
 '(warning-suppress-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
