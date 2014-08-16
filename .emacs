(require 'package)
; list the packages you want
(setq package-list '(cider
                     clojure-mode
                     autopair
                     flycheck
                     flycheck-hdevtools
                     markdown-mode
                     sass-mode
                     evil
                     evil-leader
                     smartparens
                     projectile
                     rainbow-delimiters
                     magit
                     git-gutter
                     gist
                     paredit
                     evil-surround
                     magit
                     minitest
                     color-theme
                     rvm))

(load-file "~/.emacs.d/init.el")
; list the repositories containing them
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'magit)

;; Always ALWAYS use UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")

;; copy and paste
(setq interprogram-cut-function 'paste-to-osx 
      interprogram-paste-function 'copy-from-osx) 

(defun copy-from-osx () 
  (let ((coding-system-for-read 'utf-8)) 
    (shell-command-to-string "pbpaste"))) 

(defun paste-to-osx (text &optional push) 
  (let ((process-connection-type nil)) 
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy"))) 
      (set-process-sentinel proc 'ignore) ;; stifle noise in *Messages* 
      (process-send-string proc text) 
      (process-send-eof proc))) 
  text) 

;; Always ask for y/n keypress instead of typing out 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; auto saving
(setq auto-save-default t)
(setq auto-save-visited-file-name t)
(setq auto-save-interval 20) ; twenty keystrokes
(setq auto-save-timeout 1) ; 1 second of idle time

(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))
(setq create-lockfiles nil)

;; surround
(require 'evil-surround)
(global-evil-surround-mode 1)

; General UI stuff
(global-linum-mode t)
(global-hl-line-mode t)
(setq inhibit-startup-message t)
(setq x-underline-at-descent-line t)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless (display-graphic-p) (menu-bar-mode -1))
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)
(setq column-number-mode t)
(setq ns-pop-up-frames nil)

(require 'server)
(unless (server-running-p)
  (server-start))

(setq-default show-trailing-whitespace t)
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(setq-default visible-bell 'top-bottom)
(setq-default default-tab-width 2)
(setq-default indent-tabs-mode nil)

;; automatically clean up bad whitespace
(setq whitespace-action '(auto-cleanup))

;; This gives you a tab of 2 spaces
(custom-set-variables '(coffee-tab-width 2))

(require 'minitest)
(add-hook 'ruby-mode-hook 'minitest-mode)

(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/themes/color-theme-railscasts.el")
(color-theme-railscasts)

(set-default-font "M+ 1mn-15")

;; See http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_620.html
;; and http://www.gnu.org/software/emacs/manual/elisp.pdf
;; disable line wrap
(setq default-truncate-lines t)
;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'eval-buffer
  "," 'projectile-find-file
  "t" 'dired-jump
  "c" 'comment-or-uncomment-region
  "w" 'save-buffer
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

(require 'evil)
(evil-mode t)

(require 'rainbow-delimiters nil)
(global-rainbow-delimiters-mode t)

(require 'icomplete)

(smartparens-global-mode t)

(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'prelude-common-lisp)
(require 'prelude-ruby)
(require 'prelude-scss)
(require 'prelude-coffee)
(require 'prelude-clojure)
(require 'prelude-ido)

(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'handlebars-mode)
