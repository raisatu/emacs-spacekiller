;; emacs-spacekiller.el --- 
;;
;; Author:  <raisatu@sabayon.local>
;; Version: 0.1
;; URL: 
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;; .
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

(defvar emacs-spacekiller-alist '()
  "Alist for emacs spacekiller.
Consists of modes and expressions. The expression will be evaluated to the count of
the spaces, that will be deleted.")

(defvar emacs-spacekiller-default 'tab-width
  "Default expression whose evaluation result is a count of spaces that will be deleted.")

(defmacro define-spacekiller (name check-form delete-form)
  (declare (indent 1))

  `(defun ,(intern (format "emacs-spacekiller-%s"
                           name)) ()
     (interactive)

     (let* ((expression (cdr (assoc major-mode
                                    emacs-spacekiller-alist)))
            (count      (eval (if expression
                                  expression
                                emacs-spacekiller-default))))
       (if ,check-form
           (dotimes (_i count)
             (if ,check-form
                 ,delete-form))
         ,delete-form))))

(define-spacekiller backspace
  (eq (char-before)
      ? )
  (delete-char -1))

(define-spacekiller del
  (eq (char-after)
      ? )
  (delete-char 1))

(provide 'spacekiller)
;;; emacs-spacekiller.el ends here
