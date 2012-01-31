					; -*- mode: emacs-lisp;-*-
;;chenfengyuan
;; Time-stamp: <2012-01-31 18:23:43 cfy>

;;load-path
(cond ((eq system-type 'gnu/linux)
       (add-to-list 'load-path "~/.lisp")
       (add-to-list 'load-path "~/quicklisp/dists/quicklisp/software/slime-20111105-cvs")
       )
      ((eq system-type 'windows-nt)
       ))

;;补全
;;在auto-complete不能不全的地方使用
(global-set-key (kbd "M-/") 'hippie-expand)

(display-time)
;;显示time,load level,mail flag
(show-paren-mode t)
;;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号。
;;(put 'narrow-to-region 'disabled nil)
;;
;;(setq inhibit-startup-screen t)
;;启动时直接进*scratch*
;;显示电池信息
(display-battery-mode)
;; 把f5绑定为magit-status
(global-set-key (quote [f5]) (quote magit-status))
;; 把f6绑定为compile 
(global-set-key (quote [f6]) (quote compile))
;; bind the slime-selector function to F12
(global-set-key (quote [f7]) (quote slime-selector))
;;把C-x C-m和C-c C-m 替代M-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
;; slime-close-parens-at-point
(global-set-key "" (quote slime-close-all-parens-in-sexp))
;;把Enter代替C-j
(global-set-key "\C-m" (quote newline-and-indent))
;; 设置只能在gnu/linux下使用的键绑定
;;(cond ((eq system-type 'gnu/linux)
;;把C-S-r设为 isearch-backward-word,可能只在使用kbd的地方有效.
(global-set-key (kbd "C-S-r") 'isearch-backward-word)
;;       )
;;      )
;;把C-S-s设为 isearch-forward-word
(global-set-key (kbd "C-S-s") 'isearch-forward-word)
;;更改regexp的设置
(setq search-whitespace-regexp "[ \t\r\n]+")
;;更改frame title 的显示信息
(setq frame-title-format "%I\t%b\temacs")

;; ;; 光标颜色
;; (set-cursor-color "green")
;;光标靠近鼠标时，鼠标自动让开
;; (mouse-avoidance-mode 'animate)

;;设个大点的kill ring，默认为60。
(setq kill-ring-max 200)

;;time-stamp
(add-hook 'write-file-hooks 'time-stamp)

;;backup settings
(setq make-backup-files t)
;; ;;默认为t
;; (cond ((eq system-type 'gnu/linux)      ;;为gnu/linux打开numbered backup
(setq backup-directory-alist
      '(("." . "~/.saves")))
;;        (setq version-control t)	;;打开Numbered backup
;;        (setq kept-new-versions 5)	;;保存5个最新的版本
;;        (setq delete-old-versions t)	;;打开自动删除旧的版本。



;; ;;     (setq backup-by-copying-when-linked t) ;; Copy linked files, don't rename.
;; 	(defun force-backup-of-buffer ()
;; 	  (let ((buffer-backed-up nil))
;; 	    (backup-buffer)))
;; 	(add-hook 'before-save-hook  'force-backup-of-buffer)
;; 	)
;;       )

;; use y-or-n-p instead of yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)
;; column-number-mode
(column-number-mode)



;;插件


;;configuration for company
;;company is too slow in windows-nt,so i just use auto-complete instead.
;;(cond
;; ((eq system-type 'gnu/linux)
;;  (add-to-list 'load-path "~/.lisp/company")
;;  (autoload 'company-mode "company" nil t)
;;  )
;; ((eq system-type 'windows-nt)
;; (autoload 'company-mode "company" nil t)
;;      )
;; )




;;iswitchb mode
(iswitchb-mode)

;;ascii code display
;; (require 'ascii)


;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
;;(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
;;(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
;;(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")
(define-key ac-completing-map "\M-n" 'ac-next)
(define-key ac-completing-map "\M-p" 'ac-previous)
(setq ac-auto-start 2)
(setq ac-modes (append ac-modes '(scheme-mode)))
;;(setq ac-dwim t)
;;default variable is t


;;dired-single
(require 'dired-single)
(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "RET") 'joc-dired-single-buffer)
            (define-key dired-mode-map (kbd "<mouse-1>") 'joc-dired-single-buffer-mouse)
            (define-key dired-mode-map (kbd "^")
              (lambda ()
                (interactive)
                (joc-dired-single-buffer "..")))))


;; ;; color-theme
;; (require 'color-theme)
;; ;; for color-theme-select
;; (defun color-theme-face-attr-construct (face frame)
;;   (if (atom face)
;;       (custom-face-attributes-get face frame)
;;     (if (and (consp face) (eq (car face) 'quote))
;; 	(custom-face-attributes-get (cadr face) frame)
;;       (custom-face-attributes-get (car face) frame))))
;; (color-theme-initialize)
;; ;; (color-theme-pok-wog)
;; ;; (color-theme-charcoal-black)
;; ;;(color-theme-sitaramv-nt)
;; (color-theme-infodoc)

;; igrep
(autoload 'igrep "igrep"
  "*Run `grep` PROGRAM to match REGEX in FILES..." t)
(autoload 'igrep-find "igrep"
  "*Run `grep` via `find`..." t)
(autoload 'igrep-visited-files "igrep"
  "*Run `grep` ... on all visited files." t)
(autoload 'dired-do-igrep "igrep"
  "*Run `grep` on the marked (or next prefix ARG) files." t)
(autoload 'dired-do-igrep-find "igrep"
  "*Run `grep` via `find` on the marked (or next prefix ARG) directories." t)
(autoload 'Buffer-menu-igrep "igrep"
  "*Run `grep` on the files visited in buffers marked with '>'." t)
(autoload 'igrep-insinuate "igrep"
  "Define `grep' aliases for the corresponding `igrep' commands." t)

;; ;; downcase/upcase region available
;; (put 'downcase-region 'disabled nil)

;; cperl-mode is preferred to perl-mode                                        
;; is the soul of wit" <foo at acm.org>
;; (defalias 'perl-mode 'cperl-mode)

;; the more robust equivalent:
(mapc
 (lambda (pair)
   (if (eq (cdr pair) 'perl-mode)
       (setcdr pair 'cperl-mode)))
 (append auto-mode-alist interpreter-mode-alist )
 )

;; (cperl-set-style 'PerlStyle)
(add-hook 'cperl-mode-hook 'cperl-mode-hook t)
(defun cperl-mode-hook()
  (cperl-set-style "PerlStyle")
  )
;; cperl indent
(setq cperl-auto-newline t)
(setq cperl-electric-paren t)
;; (setq cperl-electric-keywords t)

;; c/l mode
(setq c-default-style "linux")
(setq c-auto-newline t)

;; 字体
;; (defun set-font (font size)
;;   (set-fontset-font (frame-parameter nil 'font)
;; 		    'han (font-spec :family font  :size size))
;;   (set-fontset-font (frame-parameter nil 'font)
;; 		    'symbol (font-spec :family font  :size size))
;;   (set-fontset-font (frame-parameter nil 'font)
;; 		    'cjk-misc (font-spec :family font :size size))
;;   (set-fontset-font (frame-parameter nil 'font)
;; 		    'bopomofo (font-spec :family font :size size)))
;; (set-frame-font "monofur:pixelsize=20")
;; (set-fontset-font (frame-parameter nil 'font)
;; 		    'han (font-spec :family "Heiti SC Light"))
(mapc
 (lambda (face)
   (set-face-attribute face nil :weight 'normal :underline nil))
 (face-list))
(set-frame-font "DejaVu Sans Mono:pixelsize=15")
(set-fontset-font (frame-parameter nil 'font)
		    'han (font-spec :family "vera Sans YuanTi Mono"))
;; (set-frame-font "DejaVu Sans Mono:pixelsize=15")
;; (set-font "Vera Sans YuanTi Mono" 15)
;; ;; (set-default-font "WenQuanYi Micro hei 15")



;;; easypg，emacs 自带
(require 'epa-file)
(epa-file-enable)
;; 总是使用对称加密
(setq epa-file-encrypt-to nil)
;; 允许缓存密码，否则编辑时每次保存都要输入密码
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; 允许自动保存
(setq epa-file-inhibit-auto-save nil)

;;; ccrypt，需要安装 ccrypt 包
;;(require 'jka-compr-ccrypt)


;;sawfish

;; (autoload 'sawfish-mode "sawfish" "sawfish-mode" t)
;; (setq auto-mode-alist (cons '("\\.sawfishrc$"  . sawfish-mode) auto-mode-alist)
;;       auto-mode-alist (cons '("\\.jl$"         . sawfish-mode) auto-mode-alist)
;;       auto-mode-alist (cons '("\\.sawfish/rc$" . sawfish-mode) auto-mode-alist))

;;set the default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "opera")


;;linum-mode
(global-linum-mode t) 

;;cursor
(blink-cursor-mode nil)

;; ;;pinbar
;; (require 'pinbar)
;; (global-set-key (kbd "M-0") 'pinbar-add)
;; (pinbar-mode t)

;;paste2
(require 'paste2)

;;emacs server
(server-start)

;; ;;turn off menu bar and tool bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;;elscreen
(require 'elscreen)
(elscreen-set-prefix-key "\C-l")

(global-set-key "" (quote recenter-top-bottom))

;;desktop save
(desktop-save-mode 1)

;;org mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;;(define-key global-map "\M-/" 'org-complete)
(setq org-log-done t)
(setq ac-modes
      (append ac-modes '(org-mode objc-mode jde-mode sql-mode
                                  change-log-mode text-mode
                                  makefile-gmake-mode makefile-bsdmake-mo
                                  autoconf-mode makefile-automake-mode)))
;; turn on soft wrapping mode for org mode
(add-hook 'org-mode-hook
	  (lambda () (setq truncate-lines nil)))



;; (require 'socks)
;; (setq socks-noproxy '("localhost"))
;; (setq socks-override-functions 1)
;; (setq erc-server-connect-function 'socks-open-network-stream)
;; (setq socks-server '("Default server" "localhost" 7010 5))
;;erc
;;屏蔽公共信息
;; (erc-track-mode t)                                                              
;; (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"              
;;                                  "324" "329" "332" "333" "353" "477"))          
;; ;; don't show any of this                                                       
;; (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(defun erc-cmd-HOWMANY (&rest ignore)
  "Display how many users (and ops) the current channel has."
  (erc-display-message nil 'notice (current-buffer)
		       (let ((hash-table (with-current-buffer
					     (erc-server-buffer)
					   erc-server-users))
			     (users 0)
			     (ops 0))
			 (maphash (lambda (k v)
				    (when (member (current-buffer)
						  (erc-server-user-buffers v))
				      (incf users))
				    (when (erc-channel-user-op-p k)
				      (incf ops)))
				  hash-table)
			 (format
			  "There are %s users (%s ops) on the current channel"
			  users ops))))

(defun erc-cmd-SHOW (&rest form)
  "Eval FORM and send the result and the original form as:FORM => (eval FORM)."
  (let* ((form-string (mapconcat 'identity form " "))
	 (result
	  (condition-case err
	      (eval (read-from-whole-string form-string))
	    (error
	     (format "Error: %s" error)))))
    (erc-send-message (format "%s => %S" form-string result))))

(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(load "~/.emacs-passwd")
(setq erc-email-userid "cfy")
(setq erc-autojoin-channels-alist
      '(("freenode.net"
	 "#ubuntu-cn" "#gentoo-cn" "#lisp-zh" 
	 "#qi-hardware-cn")))
(setq erc-autojoin-timing 'ident)
(defun erc-start ()
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick "cfy"))
(require 'erc-log)
(setq erc-log-file-coding-system 'utf-8)
(setq erc-enable-logging 'erc-log-all-but-server-buffers)
(setq erc-log-channels-directory
      (concat "~/.irc-logs/"
	      (format-time-string "%Y%m%d" (current-time))
	      "/")) ; must be writable
(erc-log-enable)
(require 'erc-view-log)
(add-to-list 'auto-mode-alist '("~/\\.irc-logs/.*\\.txt" . erc-view-log-mode))

;; ;;; erc nick highlight
;; (and
;;      (load-library "erc-highlight-nicknames")
;;      (add-to-list 'erc-modules 'highlight-nicknames)
;;      (erc-update-modules))
     
;;; erc nick notify
(autoload 'erc-nick-notify-mode "erc-nick-notify"
  "Minor mode that calls `erc-nick-notify-cmd' when his nick gets
mentioned in an erc channel" t)
(eval-after-load 'erc '(erc-nick-notify-mode t))

;; (require 'tls)
;; (defun start-irc ()
;;    "Connect to IRC."
;;    (interactive)
;;    (erc-tls :server "irc.freenode..net" :port 6697
;;         :nick "cfy" :full-name )
;;    (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#screen" "#ion")
;;                                        ("oftc.net" "#debian"))))


;; (setq inferior-lisp-program "/usr/bin/sbcl")
(setq inferior-lisp-program "ccl -K utf-8"
      slime-net-coding-system 'utf-8-unix
      common-lisp-hyperspec-root "file:///usr/share/doc/hyperspec-7.0/HyperSpec/")
(require 'slime)

(autoload 'dictionary-search "dictionary"
  "Ask for a word and search it in all dictionaries" t)
(autoload 'dictionary-match-words "dictionary"
  "Ask for a word and search all matching words in the dictionaries" t)
(autoload 'dictionary-lookup-definition "dictionary"
  "Unconditionally lookup the word at point." t)
(autoload 'dictionary "dictionary"
  "Create a new dictionary buffer" t)
(autoload 'dictionary-mouse-popup-matching-words "dictionary"
  "Display entries matching the word at the cursor" t)
(autoload 'dictionary-popup-matching-words "dictionary"
  "Display entries matching the word at the point" t)
(autoload 'dictionary-tooltip-mode "dictionary"
  "Display tooltips for the current word" t)
(autoload 'global-dictionary-tooltip-mode "dictionary"
  "Enable/disable dictionary-tooltip-mode for all buffers" t)
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
(global-set-key [(control c)(d)] 'dictionary-lookup-definition)
(setq dictionary-server "localhost")

;;swank
(defun sc()
  (interactive)
  (slime-connect "127.0.0.1" "4004"))
;; (sc)
(setq slime-description-autofocus t)
;; ccl
(defun ccl()
  (interactive)
  (slime-start* '(:name "ccl" :program "ccl" :program-args ("-K" "utf-8"))))

;;; sbcl
(defun sbcl()
  (interactive)
  (slime-start* '(:name "sbcl" :program "/home/cfy/.bin/sbcl")))

;; slime tab indent
(defun lisp-indent-or-complete(&optional arg)
  (interactive "p")
  (if (or (looking-back "^\\s-*")(bolp))
      (call-interactively 'lisp-indent-line)
    (call-interactively 'slime-indent-and-complete-symbol)))
(eval-after-load "lisp-mode"
  '(progn
     (define-key lisp-mode-map (kbd "TAB") 'lisp-indent-or-complete)))

;; turn off ring bell
(setq ring-bell-function 'ignore)

;;erc-start
;; (erc-start)

(require 'paredit)
(define-key slime-mode-map (kbd "(") 'paredit-open-parenthesis)
(define-key slime-mode-map (kbd ")") 'paredit-close-parenthesis)

(define-key slime-mode-map (kbd "\"") 'paredit-doublequote)
(define-key slime-mode-map (kbd "\\") 'paredit-backslash)

(define-key slime-mode-map (kbd "RET") 'paredit-newline)
(define-key slime-mode-map (kbd "<return>") 'paredit-newline)
(define-key slime-mode-map (kbd "C-j") 'newline)

;;;; nb: this assumes dvorak key layout
(define-key slime-mode-map (kbd "M-b") 'backward-sexp)
(define-key slime-mode-map (kbd "M-t") 'transpose-sexps)
(define-key slime-mode-map (kbd "C-M-t") 'transpose-chars)
(define-key slime-mode-map (kbd "M-f") 'forward-sexp)
(define-key slime-mode-map (kbd "M-d") 'kill-sexp)
(define-key slime-mode-map (kbd "C-M-k") 'paredit-kill)
(define-key slime-mode-map (kbd "C-'") 'paredit-splice-sexp)
(define-key slime-mode-map (kbd "C-M-l") 'paredit-recentre-on-sexp)
(define-key slime-mode-map (kbd "C-,") 'paredit-backward-slurp-sexp)
(define-key slime-mode-map (kbd "C-.") 'paredit-forward-slurp-sexp)
(define-key slime-mode-map (kbd "C-<") 'paredit-backward-barf-sexp)
(define-key slime-mode-map (kbd "C->") 'paredit-forward-barf-sexp)
(define-key slime-mode-map (kbd "C-/") 'backward-up-list)
(define-key slime-mode-map (kbd "C-=") 'down-list)
(define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
(define-key slime-mode-map (kbd "C-c TAB") 'slime-complete-form)
;;;; this may seem strange, but i often use the C-<whatever> motion
;;;; commands in sequence to reformat code and having to take a finger off of control
;;;; to add a return is a pain
(define-key slime-mode-map (kbd "C-<return>") 'paredit-newline)
;;;; i hate having to take my key off of ctrl for this and i don't use complete-form anyway...
(define-key slime-mode-map (kbd "C-c C-i") 'slime-inspect)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
(setq hl-paren-colors
      '("red1" "orange1" "yellow1" "green1" "cyan1"
	"slateblue1" "magenta1" "purple"))

(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.vbs$" .
                                 visual-basic-mode)) auto-mode-alist))
;;; ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; enable primary selection in emacs24
(setq x-select-enable-primary t)

;;; elpa
(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("marmalade"
	 . "http://marmalade-repo.org/packages/") t)

;;; active savehist mode
(savehist-mode t)

;;;
(require 'zenburn-theme)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-current-nick-face ((t (:foreground "#B80049")))))
