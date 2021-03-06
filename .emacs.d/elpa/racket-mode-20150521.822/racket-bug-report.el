;;; racket-bug-report.el

;; Copyright (c) 2013-2015 by Greg Hendershott.
;; Portions Copyright (C) 1985-1986, 1999-2013 Free Software Foundation, Inc.

;; Author: Greg Hendershott
;; URL: https://github.com/greghendershott/racket-mode

;; License:
;; This is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version. This is distributed in the hope that it will be
;; useful, but without any warranty; without even the implied warranty
;; of merchantability or fitness for a particular purpose. See the GNU
;; General Public License for more details. See
;; http://www.gnu.org/licenses/ for details.

(require 'cl-lib)

(defconst racket--source-dir
  (file-name-directory (or load-file-name (buffer-file-name))))

;;;###autoload
(defun racket-bug-report ()
  "Fill a buffer with data to make a racket-mode bug report."
  (interactive)
  (unless (memq major-mode '(racket-mode racket-repl-mode))
    (user-error "Please run this from a racket-mode or racket-repl-mode buffer."))
  (with-help-window "*racket-mode bug report*"
    (princ "Please copy and paste this into your bug report at:\n\n")
    (princ "  https://github.com/greghendershott/racket-mode/issues/new\n\n")
    (princ "```\n")
    (cl-labels ((id-val (id) (list id
                                   (condition-case () (symbol-value id)
                                     (error 'UNDEFINED)))))
      (let ((emacs-uptime (emacs-uptime)))
        (pp `(,@(mapcar #'id-val
                        `(emacs-version
                          emacs-uptime
                          system-type
                          major-mode
                          racket--source-dir
                          racket-racket-program
                          racket-raco-program
                          racket-memory-limit
                          racket-error-context
                          racket-history-filter-regexp
                          racket-images-inline
                          racket-images-keep-last
                          racket-images-system-viewer
                          racket-pretty-print
                          racket-indent-curly-as-sequence
                          racket-indent-sequence-depth
                          racket-pretty-lambda
                          racket-smart-open-bracket-enable
                          racket-use-company-mode)))))
      ;; Show lists of enabled and disabled minor modes, each sorted by name.
      (let* ((minor-modes (cl-remove-duplicates
                           (append minor-mode-list
                                   (mapcar #'car minor-mode-alist))))
             (modes/values (mapcar #'id-val minor-modes))
             (sorted (sort modes/values
                           (lambda (a b)
                             (string-lessp (format "%s" (car a))
                                           (format "%s" (car b)))))))
        (cl-labels ((f (x) (list (car x)))) ;car as a list so pp line-wraps
          (pp `(enabled-minor-modes  ,@(mapcar #'f (cl-remove-if-not #'cadr sorted))))
          (pp `(disabled-minor-modes ,@(mapcar #'f (cl-remove-if     #'cadr sorted))))))
      (princ "```\n"))))

(defun racket-bug-report--val (id)
)

(provide 'racket-bug-report)

;; Local Variables:
;; coding: utf-8
;; comment-column: 40
;; indent-tabs-mode: nil
;; require-final-newline: t
;; show-trailing-whitespace: t
;; End:

;;; racket-bug-report.el ends here
