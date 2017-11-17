;; ============================================================
;; Don't edit this file, edit config.org' instead ...
;; Auto-generated at Fri Nov 17 2017-11-17T10:03:56  on host WIN10
;; ============================================================



;; #####################################################################################
(message "config • profiling: …")

(defvar my-config-el-start-time (current-time) "Time when config.el was started")
;(profiler-start 'cpu);; test startup performance - create report with M-x profiler-report


;; #####################################################################################
(message "config • Debugging on …")

(setq debug-on-error t)


;; #####################################################################################
(message "config • custom startup message …")

(message "[dh] Running Emacs %s" (emacs-version))
(message "[dh] Loading %s - %s on %s" (expand-file-name "config.org" user-emacs-directory) (system-name) (getenv "OS"))
(message "[dh] User: %s" (user-login-name))
(message "[dh] Emacs_Dir: %s" (getenv "emacs_dir"))


;; #####################################################################################
(message "config • Always loading newer files …")

(setq load-prefer-newer t)


;; #####################################################################################
(message "config • Setting dh/emacs-local-dir and dh/user-dir path …")

;; check OS type
(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (defconst dh/emacs-local-dir (concat (getenv "USERPROFILE") "\\emacs-local") "contains the path to my device specific emacs files and directories")
    (defconst dh/user-dir (getenv "USERPROFILE") "contains the path to my real operating system user directory")
   ))
 ;((string-equal system-type "darwin") ; Mac OS X
 ; (progn
 ;   (message "Mac OS X")
 ; ))
 ((string-equal system-type "gnu/linux") ; linux
  (progn
    (defconst dh/emacs-local-dir (concat (getenv "HOME") "/.emacs-local") "contains the path to my device specific emacs files and directories")
    (defconst dh/user-dir (getenv "HOME") "contains the path to my real operating system user directory")
  ))
)

;; create directory if it doesn't exist
(unless (file-directory-p dh/emacs-local-dir)
  (make-directory dh/emacs-local-dir)
)


;; #####################################################################################
(message "config • figuring out if emacs should run portable on Windows …")

(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (when (getenv "DH_EMACS_PORTABLE_DIR")
        (defconst dh/emacs-local-dir (concat (getenv "DH_EMACS_PORTABLE_DIR") "\\emacs-local") "contains the path to my device specific emacs files and directories")
        (defconst dh/user-dir (getenv "USERPROFILE") "contains the path to my real operating system user directory")
        (defconst dh/emacs_is_portable t "boolean switch that reflects if emacs is used as a portable version" )
    )))
)


;; #####################################################################################
(message "config • Figuring out, if I am at work 	    :location_switch: …")

;; setting me-at-work to true if I am at work
;  I can check for it later to enable/disable config parts
;(when (or 
;       (string= system-name "PC-1316")
;       (string= system-name "SRV-KON-XA1") ; CITRIX-Server
;       (string= system-name "SRV-KON-XA2") ; CITRIX-Server
;       (string= system-name "SRV-KON-XA3")) ; CITRIX-Server

;; will be overwritten if I am at work
(defconst dh/location-for-frame-title (concat "@NOT AT WORK") "contains the wording if I am at work or not for the frame-title") 
(when (or (string= (getenv "USERNAME") "HannaskeD")
          (string= (getenv "USERNAME") "hannasked"))       
  (message "[dh] Setting const dahan/me-at-work to true")
  (defconst dh/me-at-work t "boolean switch for work environment")
  ;; directly setting proxy - otherwise url-package couldn't work
  (setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
     ("http" . "192.168.179.77:8080")
     ("https" . "192.168.179.77:8080")))
  (defconst dh/location-for-frame-title (concat "@WORK") "contains the wording if I am at work or not for the frame-title") 

)


;; #####################################################################################
(message "config • setting dh/dropbox-dir and dh/onedrive-dir …")

(unless  (boundp 'dh/me-at-work)
     (defconst dh/not-at-work t "boolean switch for not at work packages")
     ;; setting path to Dropbox depending on user directory if it exists
     (if (file-directory-p (expand-file-name "Dropbox" dh/user-dir))
         (defconst dh/dropbox-dir (expand-file-name "Dropbox" dh/user-dir) "contains the path to my dropbox")
     )
     ;; setting path to Onedrive depending on user directory if it exists
     (if (file-directory-p (expand-file-name "OneDrive" dh/user-dir))
         (defconst dh/onedrive-dir (expand-file-name "OneDrive" dh/user-dir) "contains the path to my dropbox")
     )     
)


;; #####################################################################################
(message "config • set warning of opening large files to 100MB …")

(setq large-file-warning-threshold 100000000)


;; #####################################################################################
(message "config • inhibit the startup screen …")

(setq inhibit-startup-screen t)


;; #####################################################################################
(message "config • English time-stamps in Org-mode (instead of localized German ones): …")

(setq system-time-locale "C")


;; #####################################################################################
(message "config • setting up UTF-8 …")

;; utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))


;; #####################################################################################
(message "config • Change yes or no to y or n …")

(fset 'yes-or-no-p 'y-or-n-p)


;; #####################################################################################
(message "config • ignored file extensions for completions …")

(push ".out" completion-ignored-extensions)
(push ".pdf" completion-ignored-extensions)
(push ".synctex.gz" completion-ignored-extensions)


;; #####################################################################################
(message "config • Package and Use-Package configuration …")

(setq package-user-dir (concat dh/emacs-local-dir "/elpa"))
(require 'package) ;; You might already have this line

;; adding my lisp directory to the load-path
;; (add-to-list 'load-path "~/.emacs.d/lisp/")

;; adding the subdirectories of ~./.emacs.d/lisp/manually_installed_packages to the load-path
;;(let ((default-directory "~/.emacs.d/lisp/manually_installed_packages/"))
;;  (normal-top-level-add-subdirs-to-load-path))



(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
       (add-to-list 'package-archives (cons "melpa" url) t) 
)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

;; (add-to-list 'load-path "~/elisp")
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
  	(package-install 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t) ;; install packages if not installed
(require 'use-package)

(eval-when-compile
  (require 'use-package))
(use-package delight
   :ensure t)

(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode)
  (auto-compile-on-save-mode)
  (setq auto-compile-display-buffer nil))

(setq load-prefer-newer t)


;; #####################################################################################
(message "config • dh/upgrade-packages …")

;; automate the package upgrade process
(defun dh/upgrade-packages ()
  (pop-to-buffer "*scratch*")
  (interactive)
  (package-menu-mode)
  (package-menu-refresh)
  (package-menu-mark-upgrades)
  (package-menu-executes)
)


;; #####################################################################################
(message "config • dh/insert-line-before …")

(defun dh/insert-line-before (times)
  "Insert a newline or multiple newlines above the line containing the cursor"
  (interactive "p")
  (save-excursion       ;store position
     (move-beginning-of-line 1)
     (newline times)
  )
)

(global-set-key (kbd "C-S-o")
                 'dh/insert-line-before)


;; #####################################################################################
(message "config • dh/visit-favourite-directories …")

(defcustom dh/favourite-directories 

  '( "C:/Users/Bine/Dropbox/portable_apps/portable_emacs/.emacs.d/"
      "C:/Users/Bine/Dropbox/dahan_text/!notes/"
      "C:/Users/Bine/Dropbox/dahan_text/"
      "C:/Users/Bine/Dropbox/dahan_documents/"
      "C:/Users/Bine/Dropbox/dahan_misc/"
      "C:/Users/Bine/Dropbox/dahan_x_archiv/")
  "List of favourite directories.
Used in `dh/visit-favourite-dir'. The order here 
affects the order that completions will be offered."
  :type '(repeat directory)
  :group 'dh)

;; default is for dh/me-at-home-win
(if (boundp 'dh/me-at-work)
    (setq dh/favourite-directories '("I:/DATEN/BESCHAFF/2015/Beschaffungen_Daniel_in_Arbeit/"
				     "I:/DATEN/_Daniel/!ORG/"
				     "I:/DATEN/_Daniel/"
				     "I:/DATEN/BESCHAFF/2015/Beschaffungen_Daniel_in_Vibe_hochgeladen/"
				     "H:/Privat/"
				     )))


(defun dh/visit-favourite-dir (files-too)
  "Offer all directories inside a set of directories.
Compile a list of all directories inside each element of
`dh/favourite-directories', and visit one of them with
`ido-completing-read'.
With prefix argument FILES-TOO also offer to find files."
  (interactive "P")
  (let ((completions
         (mapcar #'abbreviate-file-name
           (cl-remove-if-not
            (if files-too #'file-readable-p
              #'file-directory-p)
            (apply #'append
              (mapcar (lambda (x)
                        (directory-files
                         (expand-file-name x)
                         t "^[^\.].*" t))
                dh/favourite-directories))))))
    (dired
     (ido-completing-read "Open directory: "
                          completions 'ignored nil ""))))

;; Note that C-x d is usually bound to dired. I find
;; this redundant with C-x C-f, so I don't mind
;; overriding it, but you should know before you do.
(define-key ctl-x-map "d" #'dh/visit-favourite-dir)


;; #####################################################################################
(message "config • dh/open-sys-file-manager			       :bind:bind_documented: …")

;; open-sys-file-manager
;; ----------
(defun dh/open-sys-file-manager ()
  "Launch the system file manager in the current directory and selects current file"
  (interactive)
  (when (string= system-type "windows-nt")
           (w32-shell-execute
              "open"
              "explorer"
              (concat "/e,/select," (convert-standard-filename buffer-file-name)))))


(global-set-key [f12]         'dh/open-sys-file-manager)        ; F12 - Open Explorer for the current file path)



;; #####################################################################################
(message "config • dh/open-my-init-file			       :bind:bind_documented: …")

(defun dh/open-my-init-file ()
  "Open my init file dh_init.org"
  (interactive)
  (find-file (expand-file-name "config.org" user-emacs-directory))
)

(global-set-key [S-f1]         'dh/open-my-init-file)  



;; #####################################################################################
(message "config • dh/open-my-current-taskfile			       :bind:bind_documented: …")

(defun dh/open-my-current-taskfile ()
  "Open my init file dh_init.org"
  (interactive)
  (when (boundp 'dh/me-at-work)
  ;;; opening dired in !ORG
  ;(dired org-directory)
  
  ;; open my BfN.org file as last command
  (find-file (concat org-directory "/Current_Tasks.org")))
)


(global-set-key [S-f12] 'dh/open-my-current-taskfile) 


;; #####################################################################################
(message "config • join lines					       :bind:bind_documented: …")

;; joins the following line onto this one
;; With point anywhere on the first line, I simply press M-j multiple times to pull the lines up. 
(global-set-key (kbd "M-j")
            (lambda ()
                  (interactive)
                  (join-line -1)))


;; #####################################################################################
(message "config • xah-make-backup-and-save …")

(defun xah-make-backup ()
  "Make a backup copy of current file or dired marked files.
If in dired, backup current file or marked files.
The backup file name is
 ‹name›~‹timestamp›~
example:
 file.html~20150721T014457~
in the same dir. If such a file already exist, it's overwritten.
If the current buffer is not associated with a file, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (let (($fname (buffer-file-name)))
    (if $fname
        (let (($backup-name
               (concat $fname "~" (format-time-string "%Y%m%dT%H%M%S") "~")))
          (copy-file $fname $backup-name t)
          (message (concat "Backup saved at: " $backup-name)))
      (if (string-equal major-mode "dired-mode")
          (progn
            (mapc (lambda ($x)
                    (let (($backup-name
                           (concat $x "~" (format-time-string "%Y%m%dT%H%M%S") "~")))
                      (copy-file $x $backup-name t)))
                  (dired-get-marked-files))
            (message "marked files backed up"))
        (user-error "buffer not file nor dired")))))

(defun xah-make-backup-and-save ()
  "backup of current file and save, or backup dired marked files.
For detail, see `xah-make-backup'.
If the current buffer is not associated with a file, nothing's done.
URL `http://ergoemacs.org/emacs/elisp_make-backup.html'
Version 2015-10-14"
  (interactive)
  (if (buffer-file-name)
      (progn
        (xah-make-backup)
        (when (buffer-modified-p)
          (save-buffer)))
    (progn
      (xah-make-backup))))


;; #####################################################################################
(message "config • full screen, global-font-lock and no startup-message …")

;;;;;
;; general appearance
;;;;;

;;; disabling the Emacs Welcome screen
(setq inhibit-startup-message t)

;; turn on syntax highlighting everywhere
(global-font-lock-mode t)

;; start in full screen
;; Start maximised (cross-platf)
(add-hook 'window-setup-hook 'toggle-frame-maximized t)


;; #####################################################################################
(message "config • cursor with adaptive width …")

(setq x-stretch-cursor t)


;; #####################################################################################
(message "config • smart-mode-line - initial settings …")

;; smart-mode-line
; setting the mode-line
(use-package smart-mode-line-powerline-theme
 :ensure t)

(use-package smart-mode-line
  :ensure t
  :init
  (progn
     (setq powerline-arrow-shape 'curve
           powerline-default-separator-dir '(right . left)
           sml/theme 'powerline
           ;sml/shorten-modes t
           sml/name-width 24
           sml/mode-width 'full
           column-number-mode t)
     (sml/setup)
))


;; #####################################################################################
(message "config • smart-mode-line - regexp …")

;(setq sml/replacer-regexp-list (list)) ; start with an empty list
;(if dh/dropbox-dir
;     (add-to-list 'sml/replacer-regexp-list
;                `((lambda (s) (concat "^" ,dh/dropbox-dir)) ":MYDB:") t)
;)


     (unless  (boundp 'dh/me-at-work)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_portable_apps/portable_emacs/.emacs.d/" ":DB_ED:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_text" ":DH_TEXT:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_latex" ":DH_LaTeX:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_misc" ":DH_MISC:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_documents" ":DH_DOCUMENTS:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:DB:dahan_x_archiv" ":DH_ARCHIV:") t))
     (when (boundp 'dh/me-at-work)
               ;; order does matter, a few abbrevations are stacked 
  	       (add-to-list 'sml/replacer-regexp-list '("^I:/DATEN/_Daniel/" ":I_DANIEL:") t)
	       (add-to-list 'sml/replacer-regexp-list '("^:I_DANIEL:misc/portable_emacs/.emacs.d/" ":ED:") t)
	       (add-to-list 'sml/replacer-regexp-list '("^:I_DANIEL:misc/snippets-work/" ":WORKSNIPPETS:") t)
               (add-to-list 'sml/replacer-regexp-list '("^:I_DANIEL:!ORG/" ":ORG:") t)
               (add-to-list 'sml/replacer-regexp-list '("^I:/DATEN/BESCHAFF/" ":BESCHAFF:") t)
	       (add-to-list 'sml/replacer-regexp-list '("^:BESCHAFF:Beschaffungen_Daniel_in_Arbeit" ":B_INARBEIT:") t)
	       (add-to-list 'sml/replacer-regexp-list '("^:BESCHAFF:Beschaffungen_Daniel_in_Vibe_hochgeladen" ":B_VIBE:") t)
               (add-to-list 'sml/replacer-regexp-list '("^H:/Privat/" ":H_PRIVAT:") t)
               (add-to-list 'sml/replacer-regexp-list '("^L:/!_Z22/DOKU/" ":L_DOKU:") t))


;; #####################################################################################
(message "config • whitespace …")

(use-package whitespace
  :ensure t
  :init
  (progn
       ;; use whitespace mode, and mark lines longer than 80 characters
       (setq whitespace-style '(face empty lines-tail trailing))
       (setq whitespace-line-column 80)
       (global-whitespace-mode)
))


;; #####################################################################################
(message "config • Theme Monokai …")

(use-package dracula-theme
  :ensure t
  :init (load-theme 'dracula t))


;; #####################################################################################
(message "config • Fonts …")

;; setting fonts, the first find will be choosen
(cond
 ((find-font (font-spec :name "IBM Plex Mono"))
  (set-frame-font "IBM Plex Mono-13"))
 ((find-font (font-spec :name "CamingoCode"))
  (set-frame-font "CamingoCode-13"))
 ((find-font (font-spec :name "Consolas"))
  (set-frame-font "Consolas-13")))


;; #####################################################################################
(message "config • frame title of Emacs …")

;; setting the frame title
(setq frame-title-format
      '("%b  -  "
	(:eval (if (buffer-file-name)
		   (abbreviate-file-name (buffer-file-name))
		 "%b")) "     Emacs " emacs-version dh/location-for-frame-title))


;; #####################################################################################
(message "config • hide the tool-bar …")

(tool-bar-mode -1)


;; #####################################################################################
(message "config • hide menu bar …")

(unless (display-graphic-p)
 (menu-bar-mode -1))


;; #####################################################################################
(message "config • some ignored file extensions for completions …")



;; #####################################################################################
(message "config • Recent files						    :location_switch: …")

(use-package recentf
  :ensure t
  :init
  (progn
       (setq recentf-max-menu-items 200)
       (setq recentf-max-saved-items 50)
       (setq recentf-save-file (expand-file-name ".recentf" dh/emacs-local-dir))
       (recentf-mode 1)
   ))  


;; #####################################################################################
(message "config • bookmarks …")

       (setq bookmark-default-file (expand-file-name ".bookmarks" dh/emacs-local-dir))


;; #####################################################################################
(message "config • saveplace						    :location_switch: …")

(use-package saveplace
  :ensure t
  :init
  (progn
       (setq save-place-file (expand-file-name ".places" dh/emacs-local-dir))
       (save-place-mode 1)
   ))


;; #####################################################################################
(message "config • smartparens …")

(use-package smartparens
  :ensure t
  :delight
  :init (smartparens-global-mode t))


;; #####################################################################################
(message "config • undo-tree …")

;; Undo tree mode - visualize your undos and branches
(use-package undo-tree
  :ensure t
  :delight
  :init
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)))


;; #####################################################################################
(message "config • ace-window							       :bind: …")

(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window) 
  )


;; #####################################################################################
(message "config • ace-link					       :bind:bind_documented: …")

(use-package ace-link
  :ensure t
  :init
    (progn 
       (ace-link-setup-default)
       (define-key org-mode-map (kbd "M-o") 'ace-link-org)))


;; #####################################################################################
(message "config • Avy …")

(use-package avy
  :ensure t
  :config
  (avy-setup-default))


;; #####################################################################################
(message "config • iedit					       :bind:bind_documented: …")

(use-package iedit
  :ensure t
  :bind ("C-;" . iedit-mode))


;; #####################################################################################
(message "config • multiple-cursors				       :bind:bind_documented: …")

(use-package multiple-cursors
   :ensure t
   :bind ( ;("C-S-c C-S-c" . mc/edit-lines)
           ("C->" . mc/mark-next-like-this)
           ("C-<" . mc/mark-previous-like-this)  
           ;("C-c C-<" . mc/mark-all-like-this)
           ("C-S-<mouse-1>". mc/add-cursor-on-click) 
         )
 )


;; #####################################################################################
(message "config • move-text					       :bind:bind_documented: …")

;; move-text - allows to move region or line with M-up or M-down
(use-package move-text
  :ensure t
  :init (move-text-default-bindings))


;; #####################################################################################
(message "config • hungrydelete …")

;; hungry-delete
; it makes backspace and C-d erase all consecutive white space in a given direction (instead of just one).
(use-package hungry-delete
  :ensure t
  :delight
  :init (global-hungry-delete-mode))


;; #####################################################################################
(message "config • rainbow-delimiters …")

;; rainbow-delimiters - colored delimeters e.g. parentheses
(use-package rainbow-delimiters
  :ensure t
  :delight
  :init
     (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
     (add-hook 'markdown-mode-hook #'rainbow-delimiters-mode)
)


;; #####################################################################################
(message "config • dired-details+ …")

(use-package dired-details+
   :ensure t)


;; #####################################################################################
(message "config • Which-Key …")

(use-package which-key
  :ensure t
  :delight
  :config
	(which-key-mode)
        (which-key-setup-minibuffer)
)


;; #####################################################################################
(message "config • expand-region …")

; expand the marked region in semantic increments (negative prefix to reduce region)
(use-package expand-region
   :ensure t
   :config
       (global-set-key (kbd "C-=") 'er/expand-region)
)


;; #####################################################################################
(message "config • Eldoc …")

(use-package "eldoc"
  :diminish eldoc-mode
  :commands turn-on-eldoc-mode
  :defer t
  :init
  (progn
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))


;; #####################################################################################
(message "config • Lispy …")

(use-package lispy
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
)


;; #####################################################################################
(message "config • company mode - autocompletion …")

(use-package company
  :ensure t
  :delight
  :defer t
  :config (global-company-mode))


;; #####################################################################################
(message "config • company-quickhelp …")

(use-package company-quickhelp
  :ensure t
  :delight
  :init
    (progn
      (company-quickhelp-mode 1)))


;; #####################################################################################
(message "config • company-auctex …")

(use-package company-auctex
  :if (boundp 'dh/not-at-work)
  :delight
  :ensure t
  :init
    (progn
       (company-auctex-init)))


;; #####################################################################################
(message "config • json …")

(use-package json-mode
  :ensure t
)


;; #####################################################################################
(message "config • yaml …")

(use-package yaml-mode
  :ensure t
  :init
  (progn 
       (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))))


;; #####################################################################################
(message "config • emmet …")

;; emmet css selectors for Markup
(use-package emmet-mode
  :ensure t
  :init 
    (progn
        (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
        (add-hook 'html-mode-hook 'emmet-mode)
        (add-hook 'css-mode-hook  'emmet-mode)))


;; #####################################################################################
(message "config • bat-mode Windows Batch files …")

;; bat-mode - for syntax highlighting of batch files
(add-to-list 'auto-mode-alist '("\\.bat$" . bat-mode))


;; #####################################################################################
(message "config • markdown-mode …")

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :delight
  :init
    (progn 
       (autoload 'markdown-mode "markdown-mode"
          "Major mode for editing Markdown files" t)
       (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
       (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
       (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
       (add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
       (setq markdown-command "multimarkdown")
       ;; link to css-styles
       ;; markdown-css-path - CSS file to link to in XHTML output (default: "").
       ;(setq markdown-css-paths (concat (getenv "HOME") "markdown-css-themes/foghorn.css"))
       ;; meta element is necessary that utf-8 umlauts are displayed correctly in the browser
       (setq markdown-xhtml-header-content "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />")  
       ;; enable org-table mode in markdown
       (add-hook 'markdown-mode-hook 'turn-on-orgtbl)))


;; #####################################################################################
(message "config • pandoc …")


(defun dh/load-my-pandoc-settings ()
  "Load my pandoc default settings"
  (interactive)
  (pandoc-set-write "docx")
)


(use-package pandoc-mode
  :ensure t
  :init
  (progn 
       (add-hook 'markdown-mode-hook 'pandoc-mode)
       (add-hook 'pandoc-mode-hook 'pandoc-load-default-settings)
       (add-hook 'pandoc-mode-hook 'dh/load-my-pandoc-settings)))


;; #####################################################################################
(message "config • textile …")

(use-package textile-mode
  :if (boundp 'dh/not-at-work)
  :ensure t
  :init
  (progn
       (add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))))


;; #####################################################################################
(message "config • restructured text …")

(require 'rst)
(setq auto-mode-alist
      (append '(("\\.txt\\'" . rst-mode)
                ("\\.rst\\'" . rst-mode)
                ("\\.rest\\'" . rst-mode)) auto-mode-alist))


;; #####################################################################################
(message "config • AUCTeX - LaTeX …")

;; AUCTeX aktivieren - Hilfe C-h i m auctex
;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)
;;  make AUCTeX aware of style files and multi-file documents
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
    (function
        (lambda ()
            (define-key LaTeX-mode-map (kbd "C-c C-a")
                'align-current))))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;; #####################################################################################
(message "config • Rust								:not_at_work: …")

(use-package rust-mode
  :if (boundp 'dh/not-at-work)
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :config
  (setq rust-format-on-save t) ; enabling running rustfmt automatically on save
)
(use-package racer
  :if (boundp 'dh/not-at-work)
  :ensure t
  :init
    (progn
     (add-hook 'rust-mode-hook #'racer-mode)
     (add-hook 'racer-mode-hook #'eldoc-mode)
     (add-hook 'racer-mode-hook #'company-mode)

     (require 'rust-mode)
     (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
     (setq company-tooltip-align-annotations t)
  ))
(use-package flycheck-rust
  :if (boundp 'dh/not-at-work)
  :ensure t
  :init
    (progn (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))
)


;; #####################################################################################
(message "config • TOML used by Rust cargo					:not_at_work: …")

(use-package toml-mode
  :if (boundp 'dh/not-at-work)
  :ensure t)


;; #####################################################################################
(message "config • company-jedi …")

(use-package company-jedi             ;;; company-mode completion back-end for Python JEDI
  :if (boundp 'dh/not-at-work)
  :delight
  :config
  (setq jedi:environment-virtualenv (list (expand-file-name "~/.emacs.d/.python-environments/")))
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  (setq jedi:use-shortcuts t)
  (defun config/enable-company-jedi ()
    (add-to-list 'company-backends 'company-jedi))
  (add-hook 'python-mode-hook 'config/enable-company-jedi))


;; #####################################################################################
(message "config • hydra …")

(use-package hydra
  :ensure t)


;; #####################################################################################
(message "config • Vergabe-Templates Hauptmenü			  :hydrabind:hydradocumented: …")

(defun dh/expand-snippet (str)
  "Expand yas snippet template."
  (insert str)
  (yas-expand))

(defhydra dh-vergabesnippets-main (:foreign-keys warn :exit t :hint nil)
  "
Vergabe-Snippets Hauptmenü

_t_: Allgemeine Vergabe-Templates     

_b_: Begründungen                      _a_: Vergabearten nach § 3 VOL/A


_k_: Kurzbegründung                    _v_: Telefon/Gesprächsvermerk               _s_: Sonstige Templates

"
  ("t" dh-vergabesnippets-templates/body)
  ("b" dh-vergabesnippets-begruendungen/body)  
  ("a" dh-vergabesnippets-vergabearten/body)
  ("k" (dh/expand-snippet "v_t_kb"))  
  ("v" (dh/expand-snippet "w_tv"))
  ("s" dh-vergabesnippets-sonstige/body)
  ("q" nil "Quit"))

(global-set-key [f10] 'dh-vergabesnippets-main/body)

(defhydra dh-vergabesnippets-templates (:foreign-keys warn :exit t :hint nil)
  "
Vergabe-Snippets - Allgemeine Templates

_k_: Kurzbegründung               _A_: Auftragserteilung (nach Auswertung)
_a_: Angebotsabfrage              _r_: Angebotsabfrage aus RV                _c_: Angebotsabfrage RV Computacenter
_b_: Beauftragung per E-Mail      _R_: Beauftragung aus RV per E-Mail                                     
"
  ("k" (dh/expand-snippet "v_t_kb"))
  ("A" (dh/expand-snippet "v_t_auftragserteilung"))
  ("a" (dh/expand-snippet "v_t_angebotsabfrage"))
  ("r" (dh/expand-snippet "v_t_angebotsabfrage_rv"))
  ("c" (dh/expand-snippet "v_t_angebotsabfrage_rv_20021"))    
  ("b" (dh/expand-snippet "v_t_beauftragung_email"))    
  ("R" (dh/expand-snippet "v_t_beauftragung_email_rv"))    
  ("z" dh-vergabesnippets-main/body "Zurück zum Hauptmenü")
  ("q" nil "Quit"))

(defhydra dh-vergabesnippets-vergabearten (:foreign-keys warn :exit t :hint nil)
  "
Vergabe-Snippets - Vergabearten

_r_: Abruf aus Rahmenvertrag                                                      _d_: Direktkauf - § 3 Abs. 6 VOL/A       

_ö_: Öffentliche Ausschreibung - § 3 Abs. 2 i.V.m. Abs. 1 VOL/A     
_b_: Beschränkte Ausschreibung mit Teilnahmewettbewerb - § 3 Abs. 3 a) VOL/A 
_B_: Beschränkte Ausschreibung ohne Teilnahmewettbewerb - § 3 Abs. 4 b) VOL/A

Freihändige Vergaben:
---------------------
_n_: geringfügige Nachbestellung - § 3 Abs. 5 c) VOL/A                            _D_: unverschuldete Dringlichkeit - § 3 Abs. 5 g) VOL/A
_h_: bis Höchstwert 15.000 € lt. BMUB - § 3 Abs. 5 i) VOL/A                       _1_: nur 1 Unternehmen kommt in Betracht - § 3 Abs. 5 l) VOL/A
"
  ("r" (dh/expand-snippet "v_a_rahmenvertrag"))
  ("d" (dh/expand-snippet "v_a_6_direktkauf"))
  ;; Ausschreibungen
  ("ö" (dh/expand-snippet "v_a_2_oeffentlich"))
  ("b" (dh/expand-snippet "v_a_3a_beschraenkt"))  
  ("B" (dh/expand-snippet "v_a_4b_beschraenkt"))
  ;; Freihändige Vergaben
  ("n" (dh/expand-snippet "v_a_5c_freihaendig"))
  ("D" (dh/expand-snippet "v_a_5g_freihaendig"))
  ("h" (dh/expand-snippet "v_a_5i_freihaendig"))
  ("1" (dh/expand-snippet "v_a_5l_freihaendig"))
  ("z" dh-vergabesnippets-main/body "Zurück zum Hauptmenü")
  ("q" nil "Quit"))

(defhydra dh-vergabesnippets-begruendungen (:foreign-keys warn :exit t :hint nil)
  "
Vergabe-Snippets - Begründungen

_k_: Kurzbegründung (Template)

_H_: Notwendigkeit von HP-CarePack Services

_m_: Marktüblichkeit von Vorleistungen      _h_: Bezug von Hersteller 


"
  ("k" (dh/expand-snippet "v_t_kb"))
  ("H" (dh/expand-snippet "v_b_hp_carepack"))
  ("h" (dh/expand-snippet "v_b_hersteller"))
  ("m" (dh/expand-snippet "v_b_marktueblich"))
  ("z" dh-vergabesnippets-main/body "Zurück zum Hauptmenü")
  ("q" nil "Quit"))

(defhydra dh-vergabesnippets-sonstige (:foreign-keys warn :exit t :hint nil)
  "
Vergabe-Snippets - Sonstige Templates

_v_: Telefon/Gesprächsvermerk

_p_: Protokoll FGR Z 2.1

"
  ("v" (dh/expand-snippet "w_tv"))
  ("p" (dh/expand-snippet "w_fgrZ2.2"))
  ("z" dh-vergabesnippets-main/body "Zurück zum Hauptmenü")
  ("q" nil "Quit"))


;; #####################################################################################
(message "config • Major & minor modes				  :hydrabind:hydradocumented: …")


(defhydra dh-hydra-modes (:hint nil)
  "
╔═════════════════════════════════╗
║ major & minor modes          ║
╚═════════════════════════════════╝

_t_ext        _m_arkdown     _o_rg        _e_lisp            _c_sv        _r_ust

auto-_f_ill   _a_lign        _i_spell     visual-_l_ine     _L_inum       _w_hitespace
"


  ("t" text-mode)
  ("m" markdown-mode)
  ("o" org-mode)
  ("e" lisp-mode)
  ("c" csv-mode)
  ("r" rust-mode)

  ("f" auto-fill-mode)
  ("a" align-regexp :color blue)
  ("i" ispell-buffer :color blue)
  ("l" visual-line-mode)
  ("L" linum-mode)
  ("w" whitespace-mode))

(global-set-key [S-f11] 'dh-hydra-modes/body)


;; #####################################################################################
(message "config • markdown …")

(defhydra dh-hydra-markdown-mode (:hint nil)
  "
Formatting        C-c C-s    _s_: bold          _e_: italic     _b_: blockquote   _p_: pre-formatted    _c_: code

Headings          C-c C-t    _h_: automatic     _1_: h1         _2_: h2           _3_: h3               _4_: h4

Lists             C-c C-x    _m_: insert item   

Demote/Promote    C-c C-x    _l_: promote       _r_: demote     _u_: move up      _d_: move down

Links, footnotes  C-c C-a    _L_: link          _U_: uri        _F_: footnote     _W_: wiki-link      _R_: reference
 
"


  ("s" markdown-insert-bold)
  ("e" markdown-insert-italic)
  ("b" markdown-insert-blockquote :color blue)
  ("p" markdown-insert-pre :color blue)
  ("c" markdown-insert-code)

  ("h" markdown-insert-header-dwim) 
  ("1" markdown-insert-header-atx-1)
  ("2" markdown-insert-header-atx-2)
  ("3" markdown-insert-header-atx-3)
  ("4" markdown-insert-header-atx-4)

  ("m" markdown-insert-list-item)

  ("l" markdown-promote)
  ("r" markdown-demote)
  ("d" markdown-move-down)
  ("u" markdown-move-up)  

  ("L" markdown-insert-link :color blue)
  ("U" markdown-insert-uri :color blue)
  ("F" markdown-insert-footnote :color blue)
  ("W" markdown-insert-wiki-link :color blue)
  ("R" markdown-insert-reference-link-dwim :color blue) 
)


(global-set-key [f11] 'dh-hydra-markdown-mode/body)


;; #####################################################################################
(message "config • info-help …")

(defhydra dh-hydra-info-help (:color blue
                            :columns 3)
  "dh - useful info"
  ;("C-<f1>" 'dh-hydra-info-help/body "info help (hydra)")
  ("S-<F1>" 'dh/open-my-init-file "open dh_init.org")
  ("<F12>" 'dh/open-sys-file-manager "open current directory in explorer")
  ("C-<F12>" 'xah-make-backup-and-save "make a backupfile for the current file")
  ("S-<F12>" 'dh/open-my-current-taskfile "open Current_Tasks.org")
  ("C-<F2>" 'dh-hydra-zoom/body "zoom (hydra)")

  ("<F10>" 'dh-vergabesnippets-main/body "Vergabesnippets (hydra)")
  ("<F11>" 'dh-hydra-markdown-mode/body "useful markdown commands (hydra)")
  ("S-<F11>" 'dh-hydra-modes/body "mode switching (hydra)")
  ("C-x SPC" 'dh-hydra-rectangle/body "rectangle (hydra)")
  
  ("q" nil "cancel"))

(global-set-key [C-f1] 'dh-hydra-info-help/body)



;; #####################################################################################
(message "config • org-structural-templates with < 				  :hydrabind: …")

(defhydra hydra-org-template (:color blue :hint nil)
  "
_c_enter    _q_uote        _L_aTeX:
_a_scii     _e_xample      _i_ndex:
_H_tml      _v_erse        _I_NCLUDE:
_h_tml      _p_ractice     _H_TML:
_s_rc       ^ ^            _A_SCII:

e_l_isp     _u_sepackage:
"
  ("s" (hot-expand "<s"))
  ("e" (hot-expand "<e"))
  ("l" (hot-expand "<l"))
  ("u" (hot-expand "<u"))
  ("q" (hot-expand "<q"))
  ("v" (hot-expand "<v"))
  ("c" (hot-expand "<c"))
  ("l" (hot-expand "<l"))
  ("h" (hot-expand "<h"))
  ("a" (hot-expand "<a"))
  ("L" (hot-expand "<L"))
  ("i" (hot-expand "<i"))
  ("I" (hot-expand "<I"))
  ("H" (hot-expand "<H"))
  ("A" (hot-expand "<A"))
  ("p" (hot-expand "<p"))
  ("<" self-insert-command "ins")
  ("o" nil "quit"))

(defun hot-expand (str)
  "Expand org template."
  (insert str)
  (org-try-structure-completion))


(define-key org-mode-map "<"
  (lambda () (interactive)
     (if (looking-back "^")
         (hydra-org-template/body)
       (self-insert-command 1))))


;; #####################################################################################
(message "config • rectangle mode						  :hydrabind: …")

(defun ora-ex-point-mark ()
  (interactive)
  (if rectangle-mark-mode
      (exchange-point-and-mark)
    (let ((mk (mark)))
      (rectangle-mark-mode 1)
      (goto-char mk))))

(defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                           :color pink
                           :post (deactivate-mark))
  "
  ^_k_^     _d_elete    _s_tring
_h_   _l_   _o_k        _y_ank  
  ^_j_^     _n_ew-copy  _r_eset 
^^^^        _e_xchange  _u_ndo  
^^^^        ^ ^         _p_aste
"
  ("h" backward-char nil)
  ("l" forward-char nil)
  ("k" previous-line nil)
  ("j" next-line nil)
  ("<left>" backward-char nil)
  ("<right>" forward-char nil)
  ("<up>" previous-line nil)
  ("<down>" next-line nil)
  ("e" ora-ex-point-mark nil)
  ("n" copy-rectangle-as-kill nil)
  ("d" delete-rectangle nil)
  ("r" (if (region-active-p)
           (deactivate-mark)
         (rectangle-mark-mode 1)) nil)
  ("y" yank-rectangle nil)
  ("u" undo nil)
  ("s" string-rectangle nil)
  ("p" kill-rectangle nil)
  ("o" nil nil))
(global-set-key (kbd "C-x SPC") 'hydra-rectangle/body)



;; #####################################################################################
(message "config • Zoom - text-scale				  :hydrabind:hydradocumented: …")

(defhydra dh-hydra-zoom (:hint nil)
  "
_<up>_: text-scale-increase     _<down>_: text-scale-decrease     
_k_: ^   ^text-scale-increase  ^   ^_j_: ^     ^text-scale-decrease

_r_: ^   ^reset text-scale
" 
  ("<up>" text-scale-increase)
  ("<down>" text-scale-decrease)
  ("k" text-scale-increase)
  ("j" text-scale-decreasel)
  ("r" (text-scale-set 0))
  ("0" (text-scale-set 0) :bind nil :exit t)
  ("1" (text-scale-set 0) nil :bind nil :exit t))

(global-set-key [C-f2]         'dh-hydra-zoom/body)


;; #####################################################################################
(message "config • Info					  :hydrabind:hydradocumented: …")

(defun dh/open-info (topic bname)
  "Open info on TOPIC in BNAME."
  (if (get-buffer bname)
      (progn
        (switch-to-buffer bname)
        (unless (string-match topic Info-current-file)
          (Info-goto-node (format "(%s)" topic))))
    (info topic bname)))

(defhydra hydra-info-to (:hint nil :color teal)
  "
_o_rg e_l_isp _e_macs _a_uctex _p_andoc"
  ("o" (dh/open-info "org" "*info org*"))
  ("l" (dh/open-info "elisp" "*info elisp*"))
  ("e" (dh/open-info "emacs" "*info emacs*"))
  ("a" (dh/open-info "auctex" "*info auctex*"))
  ("p" (dh/open-info "pandoc-mode" "*info pandoc*")))

(define-key Info-mode-map "t" 'hydra-info-to/body)


;; #####################################################################################
(message "config • goto-line …")

(defhydra hydra-goto-line (goto-map ""
                           :pre (linum-mode 1)
                           :post (linum-mode -1))
  "goto-line"
  ("g" goto-line "go")
  ("m" set-mark-command "mark" :bind nil)
  ("q" nil "quit"))


;; #####################################################################################
(message "config • loading ivy and activate it …")

(use-package ivy
  :ensure t
  :delight
  :config
  ;; add ‘recentf-mode’ and bookmarks to ‘ivy-switch-buffer’.
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers  t
        ivy-count-format "(%d/%d) "
   )
  (ivy-mode 1)
)

;; ivy uses flx for geneating candidates for large lists
(use-package flx
   :ensure t
   :config
   (setq gc-cons-threshold 20000000)
)

(use-package counsel
  :ensure t
  :delight
  :bind ("M-y" . counsel-yank-pop)
)

(use-package swiper
  :ensure t
  :delight
;;  :bind (())
)


;; #####################################################################################
(message "config • keybindings: ivy …")

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)


;; #####################################################################################
(message "config • ivy-hydra …")

(use-package ivy-hydra
  :ensure t
)


;; #####################################################################################
(message "config • magit setup …")

(use-package magit
  :ensure t
  :init
    (progn
       ;; disable the default version control git backend
       (setq vc-handled-backends (delq 'Git vc-handled-backends))
       ;; enabling ivy for magit
       (setq magit-completing-read-function 'ivy-completing-read)
))


;; #####################################################################################
(message "config • YASNIPPET …")

(use-package yasnippet
  :ensure t
  :delight
  :init
  (progn
      (if (boundp 'dh/me-at-work)
                (setq yas-snippet-dirs '("~/.emacs.d/snippets-dh/" "I:/DATEN/_Daniel/misc/snippets-work/" yas-installed-snippets-dir))  ;; then-part
          (setq yas-snippet-dirs '("~/.emacs.d/snippets-dh/" "~/.emacs.d/snippets-work-copy/" yas-installed-snippets-dir)))  ;; else-part
      ;; change the order of the prompt function, prefer ido
      ;;(setq  yas-prompt-functions '(yas-ido-prompt yas-x-prompt yas-dropdown-prompt yas-completing-prompt yas-no-prompt))
      (yas-global-mode 1))
)


;; #####################################################################################
(message "config • projectile setup …")

(use-package projectile
  :ensure t



)


;; #####################################################################################
(message "config • counsel-projectile …")

(use-package counsel-projectile
  :ensure t
  :init
    (counsel-projectile-on)
)


;; #####################################################################################
(message "config • Setting default org-capture target			    :implement_later: …")

;; org-capture needs a default target, the target is set in org-mode at home / at work
(define-key global-map "\C-cc" 'org-capture)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)


;; #####################################################################################
(message "config • Setting the start visibility …")

;(setq org-set-startup-visibility "fold")
(setq org-startup-folded "content")  ;; all headlines


;; #####################################################################################
(message "config • Fontify code in org code blocks …")

;; fontify code in code blocks

(setq org-src-fontify-natively t)



;; #####################################################################################
(message "config • Fixing YASnippets tab in Org-Mode …")

;; fixing tab-binding for YASnippets in Org-Mode
(add-hook 'org-mode-hook
               (lambda ()
                      (org-set-local 'yas/trigger-key [tab])
                      (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))


;; #####################################################################################
(message "config • Enabling worf-mode …")

(use-package worf
  :ensure t
  :init (add-hook 'org-mode-hook 'worf-mode))


;; #####################################################################################
(message "config • org-templates …")

(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
        ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
        ("c" "#+BEGIN_COMMENT\n?\n#+END_COMMENT")
        ("p" "#+BEGIN_PRACTICE\n?\n#+END_PRACTICE")
        ("l" "#+begin_src emacs-lisp\n?\n#+end_src" "<src lang=\"emacs-lisp\">\n?\n</src>")
        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include %file ?" "<include file=%file markup=\"?\">")))
(add-to-list 'org-structure-template-alist '("u" "#+BEGIN_SRC emacs-lisp\n(use-package ?\n  :if (boundp 'dh/not-at-work)\n  :ensure t\n  :bind ()\n  :mode ()\n  :config ()\n  :init\n    \n)\n#+END_SRC" "<src lang=\"emacs-lisp\">\n(use-package ?\n  :if (boundp 'dh/not-at-work)\n  :ensure t\n  :bind ()\n  :mode ()\n  :config ()\n  :init\n    \n)\n</src>"))


;; #####################################################################################
(message "config • org-mode at work …")

;; initialize my work config
(when (boundp 'dh/me-at-work)


(message "[dh] Setting work specific settings for org-mode")
(setq org-directory "I:/DATEN/_Daniel/!ORG")
(setq org-default-notes-file (concat org-directory "/Notes_Verschiedenes.org"))
(setq org-tag-alist '(("Beschaffung" . ?b) ("Lizenzen" . ?l) ("Mobilfunk" . ?m) 
		      ("Kommunikation" . ?k) ("ITSicherheit" . ?i) ("FGLeitung" .?f)
		      ("Verschiedenes" . ?v) ("Admin" . ?a) ("Rahmenvertrag" . ?r)))

(setq org-todo-keywords
      '((sequence "NEW(n!)" "IN_PROCESS(p!)" "WAITING_INT(i@/!)" "WAITING_EXT(e@/!)" "|" "DONE(d@)" "DELEGATED(@)" "CANCELLED(c@)")
        (sequence "O_NEW(N!)" "O_IN_PROCESS(P!)" "O_WAITING_INT(I@/!)" "O_WAITING_EXT(E@/!)" "O_APPROVAL(A!)" "O_Z1.2_APPROVAL(Z!)" "O_ORDERED(O@/!)" "O_DELIVERED(D@/!)""|" "O_DONE(@)" "O_CANCELLED(@)")
	(sequence "IDEA(!)" "|" "IDEA_APPROVED(a!)" "IDEA_CANCELLED(C!)")
	(sequence "BUG(b!)" "REPORTED(r@/!)" "|" "KNOWNCAUSE(k@)" "FIXED(f@)")))



;; description of faces - http://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html
;; colors - http://raebear.net/comp/emacscolors.html

;; monokai-colors - https://github.com/oneKelvinSmith/monokai-emacs/blob/master/monokai-theme.el


(setq org-todo-keyword-faces
      '(
	; #333333 monokai-gray-dark #3E3D31 monokai-highlight-line
	("BUG" . (:foreground "#FD5FF0" :background "#3E3D31" :weight bold)) ; monokai-magenta
	("REPORTED" . (:foreground "#F92672" :background "#3E3D31" :weight bold)) ; monokai-red
	("KNOWNCAUSE" . (:foreground "#66D9EF" :background "#3E3D31" :weight bold)) ; monokai-blue
	("FIXED" . (:foreground "#A6E22E" :background "#3E3D31" :weight bold)) ; monokai-green

	; #F3EA98 monokai-yellow-light #E6DB74 monokai-yellow
	("IDEA" . (:foreground "#333333" :weight bold :background "#E6DB74")) ; monokai-gray-d
	("IDEA_APPROVED" . (:foreground "#67930F" :weight bold :background "#E6DB74")) ; monokai-green-d
	("IDEA_CANCELLED" . (:foreground "#F92672" :weight bold :background "#E6DB74")) ; monokai-red

	;; ("TODO" . (:foreground ,red :weight bold))
	;; ("WAITING" . (:foreground ,orange :weight bold))
	;; ("DELEGATED" . (:foreground ,yellow :weight bold))
	;; ("DONE" . (:foreground ,green :weight bold))
	;; ("CANCELLED" . (:foreground ,grey :weight bold))
        ;; (:slant italic)

	("O_NEW" . (:foreground "#FD5FF0" :weight bold :slant italic)) ; monokai-magenta
	("O_IN_PROCESS" . (:foreground "#F92672" :weight bold)) ; monokai-red
	("O_WAITING_EXT" . (:foreground "#6b6b6b" :weight bold)) ; monokai-gray-light
	("O_WAITING_INT" . (:foreground "#6b6b6b" :weight bold :slant italic)) ; monokai-gray-light
        ("O_APPROVAL" . (:foreground "#AE81FF" :weight bold)) ; monokai-violet
        ("O_Z1.2_APPROVAL" . (:foreground "#C2A1FF" :weight bold)) ; monokai-violet-light
	("O_ORDERED" . (:foreground "#FD971F" :weight bold)) ; monokai-yellow
	("O_DELIVERED" . (:foreground "#A1EFE4" :weight bold)) ; monokai-cyan
	("O_DONE" . (:foreground "#A6E22E" :weight bold :slant italic)) ; monokai-green
	("O_CANCELLED" . (:foreground "#75715E" :weight bold)) ; monokai-comments

	("NEW" . (:foreground "#FD5FF0" :weight bold :slant italic)) ; monokai-magenta
	("IN_PROCESS" . (:foreground "#F92672" :weight bold)) ; monokai-red
	("WAITING_EXT" . (:foreground "#E6DB74" :weight bold)) ; monokai-yellow
	("WAITING_INT" . (:foreground "#E6DB74" :weight bold :slant italic)) ; monokai-yellow
	("DELEGATED" . (:foreground "#66D9EF" :weight bold)) ; monokai-blue
	("DONE" . (:foreground "#A6E22E" :weight bold)) ; monokai-green
	("CANCELLED" . (:foreground "#75715E" :weight bold)) ; monokai-comments


	;; ("TODO" . (:foreground "brown1" :weight bold)) ; eg. org-warning)
	;; ("WAITING" . (:foreground "LemonChiffon1" :weight bold))
	;; ("DELEGATED" . (:foreground "burlywood3" :weight bold))
	;; ("DONE" . (:foreground "LimeGreen" :weight bold))
	;; ("CANCELLED" . (:foreground "darkgrey" :weight bold))
	))

(setq org-priority-faces
      '(
	(?A . (:background "firebrick2" :weight bold :foreground "thistle1"))
	(?B . (:background "firebrick2" :weight bold :foreground "thistle1"))
	(?C . (:background "#75715E" :weight bold :foreground "thistle1")) ; bg: monokai-comments
	))


) ;; end_of_ (when (boundp 'dh/me-at-work)


;; #####################################################################################
(message "config • Fontify done checkbox items in org-mode …")

(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)" 1 'org-headline-done prepend))
 'append)


;; #####################################################################################
(message "config • Last command at work …")

;;; LAST COMMAND at work

(when (boundp 'dh/me-at-work)
  ;;; opening dired in !ORG
  ;(dired org-directory)
  
  ;; open my BfN.org file as last command
  (dh/open-my-current-taskfile)
)



;; #####################################################################################
(message "config • Debugging off …")

(setq debug-on-error nil)
