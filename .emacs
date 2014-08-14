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
                     flx-ido
                     projectile
                     rainbow-delimiters
                     magit
                     git-gutter
                     gist
                     paredit
                     evil-surround
                     ace-jump-mode
                     ack-and-a-half
                     coffee-mode
                     magit
                     minitest
                     color-theme
                     rvm))

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

;; Automatically save buffers before compiling
(setq compilation-ask-about-save nil)

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

;; ace-jump
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;If you use evil
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

;;ack config
(require 'ack-and-a-half)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

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

(add-hook 'ruby-mode-hook 'robe-mode)

(add-to-list 'auto-mode-alist
               '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode)) 

(require 'minitest)
(add-hook 'ruby-mode-hook 'minitest-mode)

(add-hook 'ruby-mode-hook
          (lambda () (rvm-activate-corresponding-ruby)))

(defun ruby-custom ()
	"ruby-mode-hook"
	(minitest-mode))
(add-hook 'ruby-mode-hook 'ruby-custom)

;; coffeescript
(custom-set-variables
 '(coffee-tab-width 2)
 '(coffee-args-compile '("-c" "--bare")))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

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
;; Add F12 to toggle line wrap
;; TODO REBIND THIS (global-set-key [f12] 'toggle-truncate-lines)

(require 'exec-path-from-shell)
(setq exec-path-from-shell-arguments
  (delete "-i" exec-path-from-shell-arguments))
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require 'smex)   ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching nil)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1) ;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(require 'recentf)
(recentf-mode 1)

(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

(setq evil-want-C-w-in-emacs-state t)
(setq evil-want-C-u-scroll t)

(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "." 'eval-buffer
  "r" 'recentf-ido-find-file
  "," 'projectile-find-file
  "t" 'direx:jump-to-directory
  "c" 'comment-or-uncomment-region
  "g" 'golden-ratio
  "w" 'save-buffer
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  ">" 'sp-slurp-hybrid-sexp) ; TODO paredit keybindings

(require 'evil)
(evil-mode t)

(evil-declare-key 'normal direx:direx-mode-map (kbd "r")   'direx:refresh-whole-tree)
(evil-declare-key 'normal direx:direx-mode-map (kbd "o")   'direx:find-item-other-window)
(evil-declare-key 'normal direx:direx-mode-map (kbd "f")   'direx:find-item)
(evil-declare-key 'normal direx:direx-mode-map (kbd "RET") 'direx:maybe-find-item)
(evil-declare-key 'normal direx:direx-mode-map (kbd "V")   'direx:view-item-other-window)
; (evil-declare-key 'normal direx:direx-mode-map (kbd "v")   'direx:view-item)
(evil-declare-key 'normal direx:direx-mode-map (kbd "g")   'direx:refresh-whole-tree)
(evil-declare-key 'normal direx:file-map       (kbd "+")   'direx:create-directory)

(evil-declare-key 'normal cider-mode-map (kbd "cpp") 'cider-eval-defun-at-point)
(evil-declare-key 'motion cider-mode-map (kbd "cpp") 'cider-eval-defun-at-point)

;forward and backwards nav
(global-set-key (kbd "C-k") (lambda () (interactive) (previous-line 10)))
(global-set-key (kbd "C-j") (lambda () (interactive) (next-line 10)))

(define-key evil-insert-state-map "k" #'cofi/maybe-exit)

(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "k")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?k)
                           nil 0.5)))
      (cond
        ((null evt) (message ""))
        ((and (integerp evt) (char-equal evt ?j))
         (delete-char -1)
         (set-buffer-modified-p modified)
         (push 'escape unread-command-events))
        (t (setq unread-command-events (append unread-command-events
                                               (list evt))))))))

(require 'rainbow-delimiters nil)
(global-rainbow-delimiters-mode t)

(require 'icomplete)

(smartparens-global-mode t)
; https://github.com/Fuco1/smartparens/wiki/Example-configuration

(require 'git-gutter)
(git-gutter:linum-setup)
(global-git-gutter-mode +1)

(add-hook 'after-init-hook #'global-flycheck-mode)

(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match
   the user's shell.  This is particularly useful under Mac OSX, where
   GUI apps are not started from a shell."
  (interactive)
  (let ((path-from-shell
	 (replace-regexp-in-string "[ \t\n]*$" ""
				   (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))


;; Enable keyboard shortcuts for resizing:
(when window-system
  (set-exec-path-from-shell-PATH)
  (global-set-key (kbd "s--") 'text-scale-decrease))

;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
