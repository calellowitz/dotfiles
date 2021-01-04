;;;Use Marmalade and MELPA

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;;; Set load path to include .emacs.d/lisp

(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Inherit Path
(exec-path-from-shell-initialize)

;;;Use Monokai

(load-theme 'monokai t)

;;;Macports commands for ehsell
(setenv "PATH" (concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH")))

;;;Homebrew commands for ehsell
(setenv "PATH" (concat "/usr/local/bin:/usr/local/sbin:" (getenv "PATH")))

;;;AucTex Stuff
;; Adds stuff to my PATH (LaTeX, etc) 
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))

;; Set the default LaTeX exec to pdfTeX
(setq TeX-PDF-mode t)

;;latexmk
(require 'auctex-latexmk)
(auctex-latexmk-setup)

;; Set default LaTeX command to LatexMk
(add-hook 'LaTeX-mode-hook '(lambda () (setq TeX-command-default "LatexMk")))

;;Environment Settings
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)

 ;; Sets the default PDF viewer to, well, the default PDF viewer.
(setq TeX-view-program-list '(("Shell Default" "open %o")))
(setq TeX-view-program-selection '((output-pdf "Shell Default")))

;;; Sets emacs to recongize .mhtml and .mas as mason

  (require 'mmm-auto)
  (setq mmm-global-mode 'maybe)
  (add-to-list 'auto-mode-alist '("\\.mas\\'" . html-mode))
  (mmm-add-mode-ext-class 'html-mode "\\.mas\\'" 'mason)
  (add-to-list 'auto-mode-alist '("\\.mhtml\\'" . html-mode))
  (mmm-add-mode-ext-class 'html-mode "\\.mhtml\\'" 'mason)

;;; js2
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;;; aspell
(setq ispell-program-name "/usr/local/bin/aspell")

;;; maybe colors
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Mutt support.
(setq auto-mode-alist (append '(("Users/temp/.mutt/temp/" . message-mode)) auto-mode-alist))
(add-hook 'message-mode-hook 'visual-line-mode)
(add-hook 'message-mode-hook 'flyspell-mode)

;; Org mode composition help
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

;;; ChucK?
(require 'chuck-mode)

;;; Racket stuff for parens
(add-hook 'racket-mode-hook 'paredit-mode)
(add-hook 'racket-mode-hook 'rainbow-delimiters-mode)

;;; octave editing

;;; fonts
; (add-to-list 'default-frame-alist '(font . "Monoid"))

;;; elpy
(elpy-enable)
;; use ag instead of grep for elpy search
(defun ag-search-at-point ()
  "search project for symbol at point"
  (interactive)
  (ag-project (thing-at-point 'symbol)))
(define-key elpy-mode-map (kbd "C-c C-s") 'ag-search-at-point)

;;; autosave
(require 'real-auto-save)
(add-hook 'prog-mode-hook 'real-auto-save-mode)

;;; use bash
(setq shell-file-name "/bin/bash")

;;; python imports
(add-hook 'python-mode-hook 'importmagic-mode)
(with-eval-after-load 'importmagic
  (define-key importmagic-mode-map (kbd "C-c C-a") 'importmagic-fix-symbol-at-point))

;;; indentation stuff
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-indent 4)
(setq js-indent-level 2)

;; ag mode
(setq ag-reuse-buffers 't)

;; midnight
(require 'midnight)
(midnight-delay-set 'midnight-delay "9:00pm")

;; dired settings
(put 'dired-find-alternate-file 'disabled nil)
