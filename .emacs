(require 'package)
; list the packages you want
(setq package-list '(cider
                     autopair
                     flycheck
                     flycheck-hdevtools
                     markdown-mode
                     sass-mode
                     smartparens
                     projectile
                     rainbow-delimiters
                     magit
                     git-gutter
                     gist
                     paredit
                     magit
                     minitest
                     color-theme
                     rbenv
                     ag))

;; Allow hash to be entered
(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
(tool-bar-mode -1)

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

(require 'color-theme)
(load-theme 'wombat t)

(set-default-font "M+ 1mn-15")

;; See http://www.delorie.com/gnu/docs/elisp-manual-21/elisp_620.html
;; and http://www.gnu.org/software/emacs/manual/elisp.pdf
;; disable line wrap
(setq default-truncate-lines t)
;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil)

(require 'rainbow-delimiters nil)
(global-rainbow-delimiters-mode t)

(require 'icomplete)

(smartparens-global-mode nil)

(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'ag)
(require 'prelude-clojure)
(require 'prelude-ruby)
(require 'prelude-scss)
(require 'prelude-coffee)
(require 'prelude-ido)
(require 'prelude-js)
(require 'prelude-key-chord)

(setq js-indent-level 2)

(setq ruby-indent-tabs-mode nil)
(setq ruby-indent-level 2)

(require 'minitest)
(add-hook 'ruby-mode-hook 'minitest-mode)

(require 'rbenv)
(global-rbenv-mode)
(rbenv-use-global)

(autoload 'enh-ruby-mode "enh-ruby-mode" "" t)
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

(setq enh-ruby-program rbenv-ruby-shim)

(add-hook 'enh-ruby-mode-hook 'minitest-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'handlebars-mode)

;; fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "TERM=vt100 $SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))

(global-set-key (kbd "C->") 'vimmy-indent)
(defun vimmy-indent () 
 (interactive)
 (indent-according-to-mode) 
 (indent-rigidly 
   (region-beginning) 
   (region-end) 2))

(global-set-key (kbd "C-<") 'vimmy-unindent)
(defun vimmy-unindent () 
 (interactive)
 (indent-according-to-mode) 
 (indent-rigidly 
   (region-beginning) 
   (region-end) -2))

(global-set-key "\M-/" 'hippie-expand)
;; Append result of evaluating previous expression (Clojure):
  (defun cider-eval-last-sexp-and-append ()
    "Evaluate the expression preceding point and append result."
    (interactive)
    (let ((last-sexp (cider-last-sexp)))
;; we have to be sure the evaluation won't result in an error
(cider-eval-and-get-value last-sexp)
(with-current-buffer (current-buffer)
  (insert ";;=>"))
(cider-interactive-eval-print last-sexp)))

; cider config
(require 'cider)
(setq nrepl-hide-special-buffers t)
(setq cider-show-error-buffer nil)
(define-key clojure-mode-map (kbd "C-o j") 'cider-jack-in)
(define-key clojure-mode-map (kbd "C-o J") 'cider-restart)
(define-key clojure-mode-map (kbd "C-o y") 'cider-eval-last-sexp-and-append)
