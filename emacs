					; -*- mode: emacs-lisp;-*-
;;chenfengyuan

;;; for compile
;;; elpa
(package-initialize)
(if (eq emacs-major-version 24)
    (progn (require 'package)
	   (add-to-list 'package-archives
			'("marmalade" . "http://marmalade-repo.org/packages/") t)
	   (add-to-list 'package-archives
              '("melpa" . "http://melpa.milkbox.net/packages/") t)
	   (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)))
(eval-when-compile
  (require 'dired))

;;load-path
(cond ((or (eq system-type 'gnu/linux)
	   (eq system-type 'darwin))
       (add-to-list 'load-path "~/.emacs.d/org-7.9.2/lisp/")
       (add-to-list 'load-path "~/.emacs.d/org-7.9.2/contrib/lisp/")
       (add-to-list 'load-path "~/.lisp")
       (add-to-list 'load-path "~/gits/elisp/")
       (add-to-list 'load-path "~/.lisp/apel-10.8")
       ;; (load "~/.emacs.d/elpa/subdirs.el")
       ;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
       )
      ((eq system-type 'windows-nt)))

;;; ir-black theme
(if (eq emacs-major-version 24)
    (add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/ir-black-theme-1.0/"))

(if (eq system-type 'darwin)
    (require 'terminal-notifier))
;; swap command and option under os x
(eval-when-compile (require 'cl))
(when (and window-system (eq system-type 'darwin))
  (rotatef mac-command-modifier mac-option-modifier))

;;补全
;;在auto-complete不能不全的地方使用
(global-set-key (kbd "M-/") 'hippie-expand)

;;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号。
(show-paren-mode t)
;;(put 'narrow-to-region 'disabled nil)
;;
;;(setq inhibit-startup-screen t)
;;启动时直接进*scratch*
;;显示电池信息
;; (display-battery-mode)
;; (setq battery-mode-line-format "[%b%p%%,%t]")
;; (if (string= "cfy" (user-real-login-name))
;;     (load "cfy-battery-linux-proc-acpi"))
;; 把f5绑定为magit-status
(global-set-key (quote [f5]) (quote magit-status))
;; 把f6绑定为compile 
(global-set-key (quote [f6]) (quote compile))
;; bind the slime-selector function to F12
(global-set-key (quote [f7]) (quote slime-selector))
;;C-c C-m 替代M-x
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

;; ;; 光标颜色
;; (set-cursor-color "green")
;;光标靠近鼠标时，鼠标自动让开
;; (mouse-avoidance-mode 'animate)

;;设个大点的kill ring，默认为60。
(setq kill-ring-max 200)

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



;;; ido
(eval-when-compile (require 'cl))
(require 'ido)
(if window-system
    (ido-mode t)
  (iswitchb-mode))
;; (add-to-list 'load-path "~/.emacs.d/elpa/ido-better-flex-0.0.2")
;; (require 'ido-better-flex)
;; (ido-better-flex/enable)

;;ascii code display
;; (require 'ascii)


;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))
(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline-p 'ac-candidate-face "darkgray")
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
;; (progn 
;;   (color-theme-initialize)
;;   (color-theme-charcoal-black))
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
;; (defun cperl-mode-hook()
;;   (cperl-set-style "PerlStyle"))
;; cperl indent
(setq cperl-auto-newline t)
(setq cperl-electric-paren t)
;; (setq cperl-electric-keywords t)

;; c/l mode
(setq c-default-style
      '((java-mode . "java")
	(awk-mode . "awk")
	(other . "linux")))
(setq c-auto-newline t)

;;; 字体
;; copy from Tux in newsmth.net
;; http://dto.github.com/notebook/require-cl.html#sec-8
;; http://stackoverflow.com/questions/5019724/in-emacs-what-does-this-error-mean-warning-cl-package-required-at-runtime
;; face-font-rescale-alist
(eval-when-compile (require 'cl))
(when window-system
  (defun set-font (english chinese english-size)
    (set-face-attribute 'default nil :font
			(format "%s:pixelsize=%d" english english-size))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font t charset
			(font-spec :family chinese))))

  (ecase system-type
    (gnu/linux
     (set-face-bold-p 'bold nil)
     (set-face-underline-p 'bold nil)
     (set-font "monofur" "vera Sans YuanTi Mono" 20))
    (darwin
     (set-font "monofur" "STHeiti" 20))))

;;; easypg，emacs 自带
(require 'epa-file)
(epa-file-enable)
;; 总是使用对称加密
(setq epa-file-encrypt-to nil)
;; 允许缓存密码，否则编辑时每次保存都要输入密码
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; 允许自动保存
(setq epa-file-inhibit-auto-save nil)
;; epa只能用gnupg 1.0
(setq epg-gpg-program "/usr/local/bin/gpg")


(global-set-key "\C-xm" 'browse-url-at-point)


;; don't blink cursor
(blink-cursor-mode -1)

;;emacs server
(server-start)

;;; turn off tool bar
;; (menu-bar-mode -1)
(when window-system
  (tool-bar-mode -1))

;;elscreen
(require 'elscreen)
(elscreen-set-prefix-key "\C-l")

(global-set-key "" (quote recenter-top-bottom))

;;desktop save
;; (desktop-save-mode nil)

;;org mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;;(define-key global-map "\M-/" 'org-complete)

(setq ac-modes
      (append ac-modes '(org-mode objc-mode jde-mode sql-mode
                                  change-log-mode text-mode
                                  makefile-gmake-mode makefile-bsdmake-mo
                                  autoconf-mode makefile-automake-mode)))
;; turn on soft wrapping mode for org mode
(add-hook 'org-mode-hook
	  (lambda () (setq truncate-lines nil)))
(define-key global-map "\C-cc" 'org-capture)
(setq org-refile-targets '(("gtd.org" :maxlevel . 1)))
(require 'org-film)
;;; display calendar in org agenda
(setq org-agenda-include-diary t)
;; org-depend
(require 'org-depend)
(setq org-depend-find-next-options "from-current,priority-up")
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
;;; auto rejoin channel when being kicked
(defun auto-rejoin(buffer)
  (let ((bn (buffer-name buffer)))
    (run-at-time "0.1 sec" nil
		 (lambda (bn)
		   (set-buffer bn)
		   (erc-join-channel bn))
		 bn)))
(add-hook 'erc-kick-hook 'auto-rejoin)

(defun erc-cmd-BAN (nick)
  (let* ((chan (erc-default-target))
         (who (erc-get-server-user nick))
         (host (erc-server-user-host who))
         (user (erc-server-user-login who)))
    (erc-server-send (format "MODE %s +b *!%s@%s" chan user host))))

(defun erc-cmd-KICKBAN (nick &rest reason)
  (setq reason (mapconcat #'identity reason " "))
  (and (string= reason "")
       (setq reason nil))
  (erc-cmd-BAN nick)
  (erc-server-send (format "KICK %s %s %s"
			   (erc-default-target)
			   nick
			   (or reason
			       "Kicked (kickban)"))))
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
	     (format "Error: %s" err)))))
    (erc-send-message (format "%s => %S" form-string result))))

(require 'erc-services)
(erc-services-mode 1)
(setq erc-prompt-for-nickserv-password nil)
(load "~/.emacs-passwd")
(setq erc-email-userid "ilisp")
(setq erc-autojoin-channels-alist
      '(("freenode.net"
	 "#lisp-zh" "#ubuntu-cn" "#avplayer"
	 "#emacs" "##mac" "#lisp" "#org-mode" "#coffeescript" "##javascript")))
(setq erc-autojoin-timing 'ident)
(require 'tls)
(defun erc-start ()
  (interactive)
  (erc-tls :server "irc.freenode.net" :port 6697 :nick "cfy"))

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

;; (require 'tls)
;; (defun start-irc ()
;;    "Connect to IRC."
;;    (interactive)
;;    (erc-tls :server "irc.freenode..net" :port 6697
;;         :nick "cfy" :full-name )
;;    (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs" "#screen" "#ion")
;;                                        ("oftc.net" "#debian"))))

;; (setq inferior-lisp-program "/usr/bin/sbcl")
(add-to-list 'load-path "~/quicklisp/dists/quicklisp/software/slime-20121125-cvs/")
(require 'slime)
(slime-setup '(slime-fancy))
(setq inferior-lisp-program "ccl -K utf-8"
      slime-net-coding-system 'utf-8-unix
      common-lisp-hyperspec-root "/Users/chenfengyuan/Library/Application Support/Dash/DocSets/Common_Lisp/Common Lisp.docset/Contents/Resources/Documents/HyperSpec/HyperSpec/"
      lisp-simple-loop-indentation 1
      lisp-loop-keyword-indentation 6
      lisp-loop-forms-indentation 6)


;; (autoload 'dictionary-search "dictionary"
;;   "Ask for a word and search it in all dictionaries" t)
;; (autoload 'dictionary-match-words "dictionary"
;;   "Ask for a word and search all matching words in the dictionaries" t)
;; (autoload 'dictionary-lookup-definition "dictionary"
;;   "Unconditionally lookup the word at point." t)
;; (autoload 'dictionary "dictionary"
;;   "Create a new dictionary buffer" t)
;; (autoload 'dictionary-mouse-popup-matching-words "dictionary"
;;   "Display entries matching the word at the cursor" t)
;; (autoload 'dictionary-popup-matching-words "dictionary"
;;   "Display entries matching the word at the point" t)
;; (autoload 'dictionary-tooltip-mode "dictionary"
;;   "Display tooltips for the current word" t)
;; (autoload 'global-dictionary-tooltip-mode "dictionary"
;;   "Enable/disable dictionary-tooltip-mode for all buffers" t)
;; (global-set-key "\C-cs" 'dictionary-search)
;; (global-set-key "\C-cm" 'dictionary-match-words)
;; (global-set-key [(control c)(d)] 'dictionary-lookup-definition)
;; (setq dictionary-server "localhost")

;;swank
(defun sc()
  (interactive)
  (slime-connect "127.0.0.1" "4004"))
;; (sc)
(setq slime-description-autofocus t)

;; ecl
(defun ecl()
  (interactive)
  (slime-start* '(:program "ecl" :program-args ("--encoding" "UTF8"))))


;; ccl
(defun ccl()
  (interactive)
  (slime-start* '(:name "ccl" :program "ccl" :program-args ("-K" "utf-8"))))

;;; sbcl
(defun sbcl()
  (interactive)
  (slime-start* '(:name "sbcl" :program "/usr/local/bin/sbcl" :program-args ("--no-sysinit"))))

;;; allgero cl
(defun acl()
  (interactive)
  (slime-start* '(:program "~/.acl81.64/alisp")))

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
(require 'ielm)
(require 'paredit)
(dolist (mode-map `(,slime-mode-map ,emacs-lisp-mode-map))
  (define-key mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
  (define-key mode-map (kbd "C-c TAB") 'slime-complete-form))
(dolist (mode-map `(,slime-mode-map ,emacs-lisp-mode-map ,lisp-interaction-mode-map ,ielm-map))
  (define-key mode-map (kbd "(") 'paredit-open-parenthesis)
  (define-key mode-map (kbd ")") 'paredit-close-parenthesis)

  (define-key mode-map (kbd "\"") 'paredit-doublequote)
  (define-key mode-map (kbd "\\") 'paredit-backslash)

  (define-key mode-map (kbd "RET") 'paredit-newline)
  (define-key mode-map (kbd "<return>") 'paredit-newline)
  (define-key mode-map (kbd "C-j") 'newline)
  (define-key mode-map (kbd "<backspace>") 'paredit-backward-delete)

;;;; nb: this assumes dvorak key layout
  (define-key mode-map (kbd "M-b") 'backward-sexp)
  (define-key mode-map (kbd "M-t") 'transpose-sexps)
  (define-key mode-map (kbd "C-M-t") 'transpose-chars)
  (define-key mode-map (kbd "M-f") 'forward-sexp)
  (define-key mode-map (kbd "M-d") 'kill-sexp)
  (define-key mode-map (kbd "C-M-k") 'paredit-kill)
  (define-key mode-map (kbd "C-k") 'paredit-kill)
  (define-key mode-map (kbd "C-'") 'paredit-splice-sexp)
  (define-key mode-map (kbd "C-M-l") 'paredit-recentre-on-sexp)
  (define-key mode-map (kbd "C-,") 'paredit-backward-slurp-sexp)
  (define-key mode-map (kbd "C-.") 'paredit-forward-slurp-sexp)
  (define-key mode-map (kbd "C-<") 'paredit-backward-barf-sexp)
  (define-key mode-map (kbd "C->") 'paredit-forward-barf-sexp)
  (define-key mode-map (kbd "C-/") 'backward-up-list)
  (define-key mode-map (kbd "C-=") 'down-list)
;;;; this may seem strange, but i often use the C-<whatever> motion
;;;; commands in sequence to reformat code and having to take a finger off of control
;;;; to add a return is a pain
  (define-key mode-map (kbd "C-<return>") 'paredit-newline)
;;;; i hate having to take my key off of ctrl for this and i don't use complete-form anyway...
  (define-key mode-map (kbd "C-c C-i") 'slime-inspect))
(define-key ielm-map (kbd "<return>") 'ielm-return)

;; (require 'highlight-parentheses)
;; (define-globalized-minor-mode global-highlight-parentheses-mode
;;   highlight-parentheses-mode
;;   (lambda ()
;;     (highlight-parentheses-mode t)))
;; (global-highlight-parentheses-mode t)
;; (setq hl-paren-colors
;;       '("red1" "orange1" "yellow1" "green1" "cyan1"
;; 	"slateblue1" "magenta1" "purple"))

(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(setq auto-mode-alist (append '(("\\.vbs$" .
                                 visual-basic-mode)) auto-mode-alist))
;;; ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;; enable primary selection in emacs24
(setq x-select-enable-primary t)



;;; active savehist mode
(savehist-mode t)

;;;
(if (eq emacs-major-version 25)
    (require 'zenburn-theme))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elscreen-display-tab nil)
 '(js2-auto-indent-p t)
 '(js2-basic-offset 8)
 '(js2-bounce-indent-p t)
 '(js2-enter-indents-newline t)
 '(js2-indent-on-enter-key t)
 '(org-agenda-files (quote ("~/Undergraduate/graduate-project/face-recognition.org" "~/orgs/birthday.org" "~/orgs/notes.org" "~/orgs/gtd.org" "~/orgs/todo.org")))
 '(org-capture-templates (quote (("g" "graduation project" entry (file+headline "~/orgs/gtd.org" "graduation project") "* TODO %?") ("t" "Todo" entry (file+headline "~/orgs/gtd.org" "Tasks") "* TODO %?
") ("u" "Undergraduate" entry (file+headline "~/orgs/gtd.org" "Undergraduate") "* TODO %?
") ("p" "Postgraduate entrance exam" entry (file+headline "~/orgs/gtd.org" "postgraduate entrance exam") "* TODO %?
") ("n" "NTU" entry (file+headline "~/orgs/gtd.org" "NTU") "* TODO %?
") ("f" "Film" entry (file+headline "~/orgs/gtd.org" "Tasks") "* TODO %?[/] :film:
- [ ] download
- [ ] watch
- [ ] review"))) t)
 '(org-enforce-todo-dependencies t)
 '(org-show-notification-handler (lambda (message) (notify "Org-mode" message))))

;; ;;; fast-paren-mode
;; (require 'fast-paren-mode)

;; (add-hook 'lisp-mode-hook  'turn-on-fast-paren-mode)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-fast-paren-mode)
;; (add-hook 'ielm-mode-hook  'turn-on-fast-paren-mode)
;; (add-hook 'lisp-interaction-mode-hook 'turn-on-fast-paren-mode)
;; (add-hook 'slime-repl-mode-hook       'turn-on-fast-paren-mode)
;; ;; 在调用slime-space之前先插入fast-paren-space
;; (defadvice slime-space (before slime-space-and-fast-paren ())
;;   (fast-paren-space))
;; ;; 在调用slime-space之后，因为slime-space始终会插入一个多余空格，所以需要删去一个
;; (defadvice slime-space (after slime-space-backward ())
;;   (backward-delete-char 1))
;; (ad-activate 'slime-space)

;; Set to the location of your Org files on your local system
(setq org-directory "~/orgs")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/orgs/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/MobileOrg")
(setq org-default-notes-file (concat org-directory "/notes.org"))

;;; disable scrool bar
(when window-system
  (scroll-bar-mode -1))

;;; zone
;; (require 'zone)
;; (setq zone-programs [zone-pgm-five-oclock-swan-dive zone-pgm-drip zone-pgm-drip-fretfully zone-pgm-five-oclock-swan-dive zone-pgm-martini-swan-dive zone-pgm-stress zone-pgm-stress-destress zone-pgm-random-life])
;; (zone-when-idle 42)

;;; erc say Hello
(defvar *sh-nicks* (make-hash-table :test 'equal))
(defvar *sh-channel* "#ubuntu-cn")
(defvar *sh-nicks-file* "~/.lisp/say-hello.nicks")
(defvar *sh-previous-sent-time* 0)
(defun say-hello ()
  (goto-char (point-min))
  (when (and (string= (buffer-name) *sh-channel*)
	     (ignore-errors (re-search-forward "^*** \\([^(]+\\) (~?\\([^@]+\\)@.*joined" nil t)))
    (let ((str (gethash (match-string-no-properties 2) *sh-nicks*)))
      (when str
	(when t
	  (setf *sh-previous-sent-time* (cadr (current-time)))
	  (erc-send-message (concat (match-string-no-properties 1) ": " str)))))))
(defun say-hello-build-nick-list ()
  (with-temp-buffer
    (clrhash *sh-nicks*)
    (insert-file-contents *sh-nicks-file* nil nil nil t)
    (while (re-search-forward "\\([^[:space:]]+\\)[[:space:]]+\\([^[:space:]]+\\)" nil t)
      (puthash (match-string-no-properties 1) (match-string-no-properties 2) *sh-nicks*))))
(say-hello-build-nick-list)

;; minimal distraction in erc track
(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))
(defadvice erc-track-modified-channels (around erc-track-modified-channels-promote-query activate)
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'nil))
  ad-do-it
  (if (erc-query-buffer-p) (setq erc-track-priority-faces-only 'all)))
(setq erc-track-faces-priority-list '(erc-current-nick-face erc-track-find-face))
(setq erc-track-priority-faces-only 'all)
;; *** blez (blez@ip-162-4-71-77.varnalan.net) has joined channel #ubuntu
;; (add-hook 'erc-insert-post-hook 'say-hello)
;; (remove-hook 'erc-insert-post-hook 'auto-hello)

;;; Auto byte-compile
;;; copy from http://xahlee.org/emacs/organize_your_dot_emacs.html
(defun auto-recompile-el-buffer ()
  (interactive)
  (when (and (eq major-mode 'emacs-lisp-mode)
             (file-exists-p (byte-compile-dest-file buffer-file-name)))
    (byte-compile-file buffer-file-name)))
(add-hook 'after-save-hook 'auto-recompile-el-buffer)

;;; face
(set-background-color "honeydew")

;;; display time and load level
;; (display-time)

;;; pretty lambda
(require 'pretty-lambdada)
(pretty-lambda-for-modes)

;;; Sort files in dired.
(require 'dired-sort)

;;;  keyfreq
;;; And use keyfreq-show to see how many times you used a command.
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;;; use woman instead of man
(defalias 'man 'woman)

;;; org export beamer
(require 'org-export-beamer)

;;; org capture
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/orgs/gtd.org" "Tasks")
	 "* TODO %?\n")
	("u" "Undergraduate" entry (file+headline "~/orgs/gtd.org" "Undergraduate")
	 "* TODO %?\n")
	("p" "Postgraduate entrance exam" entry (file+headline "~/orgs/gtd.org" "postgraduate entrance exam")
	 "* TODO %?\n")
	("n" "NTU" entry (file+headline "~/orgs/gtd.org" "NTU")
	 "* TODO %?\n")
	("f" "Film" entry (file+headline "~/orgs/gtd.org" "Tasks")
	 "* TODO %?[/] :film:\n- [ ] download\n- [ ] watch\n- [ ] review")))

;;; latex compile command
(setq LaTeX-command "xelatex")

;;; slime remote file name
(require 'slime-tramp)
(setq slime-to-lisp-filename-function
      (lambda (filename)
	(if (or (null (slime-connected-p)) (string= (slime-machine-instance) "Fengyuans-MacBook-Air"))
	    (convert-standard-filename filename)
	  (slime-tramp-to-lisp-filename filename))))
;; (setq slime-to-lisp-filename 'convert-standard-filename)

(setq slime-from-lisp-filename-function
      (lambda (filename)
	(if (or (null (slime-connected-p)) (string= (slime-machine-instance) "Fengyuans-MacBook-Air"))
	    (identity filename)
	  (slime-tramp-from-lisp-filename filename))))
;; (setq slime-from-lisp-filename-function 'identify)

(setf slime-filename-translations
      (list (slime-create-filename-translator :machine-instance "school"
					      :remote-host "10.172.230.45"
					      :username "cfy")
	    (slime-create-filename-translator :machine-instance "raspberrypi"
					      :remote-host "rpi"
					      :username "cfy")))
(put 'downcase-region 'disabled nil)

;;; toggle emacs fullscreen by setting frame property
;;; http://emacswiki.org/emacs/FullScreen
;;; copy from Ivan Kanis
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(ielm)
(require 'numbers)

;; change default frame width
(set-frame-width (selected-frame) 100)

;; imaxima
(add-to-list 'exec-path "/usr/texbin/")
(add-to-list 'exec-path "/usr/local/bin")
(setenv "PATH" "/Users/chenfengyuan/.bin:/Users/chenfengyuan/perl5/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/texbin")
(add-to-list 'load-path "/usr/local/Cellar/maxima/5.28.0/share/maxima/5.28.0/emacs")
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'imaxima "imaxima" "Frontend for maxima with Image support" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(autoload 'imath-mode "imath" "Imath mode for math formula input" t)
(setq imaxima-use-maxima-mode-flag t)

;; move to the center of display
(let ((dh (display-pixel-height))
      (dw (display-pixel-width))
      (fh (frame-pixel-height))
      (fw (frame-pixel-width)))
  (set-frame-position (selected-frame) (- (/ dw 2) (/ fw 2)) (- (/ dh 2) (/ fh 2) 42)))

;; golden-ratio
(golden-ratio-enable)

;; auto-complete-clang
(require 'yasnippet)
(pop yas-snippet-dirs)
(yas-global-mode)
(require 'auto-complete-clang)
(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)
(define-key ac-mode-map  [(control tab)] 'auto-complete)
(setq ac-auto-start nil)
(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/llvm-gcc-4.2/bin/../lib/gcc/i686-apple-darwin11/4.2.1/include
 /usr/include/c++/4.2.1
 /usr/include/c++/4.2.1/backward
 /usr/local/include
 /Applications/Xcode.app/Contents/Developer/usr/llvm-gcc-4.2/lib/gcc/i686-apple-darwin11/4.2.1/include
 /usr/include
/usr/local/Cellar/opencv/2.4.2/include/
 .
"
               )))
(setq yas-prompt-functions '(yas-ido-prompt yas-no-prompt))

;; smart-mark
(require 'smart-mark)

;; next specfial day
(load "~/gits/elisp/next-spec-day")

;; emacs c source directory
(setq find-function-C-source-directory "~/tmp/emacs/emacs-24.2/src/")

;; copy from [[http://nullprogram.com/blog/2009/05/28/][Elisp Running Time Macro]]
(defmacro measure-time (&rest body)
  "Measure and return the running time of the code block."
  (declare (indent defun))
  (let ((start (make-symbol "start")))
    `(let ((,start (float-time)))
       ,@body
       (- (float-time) ,start))))

;; ;; nodejs-mode
;; (add-to-list 'load-path "~/.emacs.d/nodejs-mode/")
;; (require 'nodejs-mode)

;; ;; lintnode
;; (let ((lintnode-path "/Users/chenfengyuan/.emacs.d/lintnode/"))
;;   (add-to-list 'load-path lintnode-path)
;;   (require 'flymake-jslint)
;;   ;; Make sure we can find the lintnode executable
;;   (setq lintnode-location lintnode-path)
;;   ;; JSLint can be... opinionated
;;   (setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;;   ;; Start the server when we first open a js file and start checking
;;   (when (fboundp 'lintnode-hook)
;;     (add-hook 'js-mode-hook
;; 	      (lambda ()
;; 		(lintnode-hook)))
;;     (add-hook 'js2-mode-hook
;; 	      (lambda ()
;; 		(lintnode-hook)))))

;; (require 'flymake-cursor)

;; coffee-script
(setq coffee-command "/usr/local/share/npm/bin/coffee")

;; copy from
(defun uniquify-region-lines (beg end)
  "Remove duplicate adjacent lines in region."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
      (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))
