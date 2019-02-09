;;; wox.el --- write on exit -*- lexical-binding: t -*-

;; Copyright (C) 2015-2019

;; Author: Ernst M. van der Linden <ernst.vanderlinden@ernestoz.com>
;; URL: https://github.com/ernstvanderlinden/wox
;; Version: 1.0.0
;; Package-Requires: ((evil))
;; Keywords: convenience

;; This file is part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;;   Write buffer on exit insert mode

;; To enable wox on Emacs startup, add following to your init.el:
;;
;;   (require 'wox)
;;
;; Once added to your init.el and/or evaluated code above, following
;; interactive functions will be available:
;;
;;   M-x wox-save-global-toggle
;;   M-x wox-save-global-enable
;;   M-x wox-save-global-disable
;;   M-x wox-save-local-toggle
;;   M-x wox-save-local-enable
;;   M-x wox-save-local-disable

(require 'evil)

(defvar wox--save-global-p -1
  "Save buffer on leaving insert mode, globally. \
Will be set on enabling or disabling global save.")

(defvar-local wox--save-local-p -1
  "Save buffer on leaving insert mode, locally. \
Will be set on enabling or disabling local save.")

(defun wox-save-buffer-has-file ()
  "Save buffer if buffer has file."
  (interactive)
  (if (buffer-file-name)
      (save-buffer)
    (message "wox: cannot save, buffer has no file (yet)")))

;;* GLOBAL
(defun wox-save-global-p ()
  "Returns to true if wox-save-global is on."
  (equal t wox--save-global-p))

(defun wox-save-global-p-message ()
  "Print message if wox-save-global is on."
  (interactive)
  (if (wox-save-global)
      (message "wox-save-global is on")
    (message "wox-save-global is off")))

(defun wox-save-global-toggle ()
  "Toggle buffer save on exit insert mode, globally."
  (interactive)
  (if (wox-save-global-p)
      (wox-save-global-disable)
    (wox-save-global-enable)))

(defun wox-save-global-enable ()
  "Enable buffer save on exit insert mode, globally."
  (interactive)
  (wox-save-local-disable)
  (setq wox--save-global-p t)
  (add-hook 'evil-insert-state-exit-hook
            'wox-save-buffer-has-file))

(defun wox-save-global-disable ()
  "Disable buffer save on exit insert mode, globally."
  (interactive)
  (setq wox--save-global-p -1)
  (remove-hook 'evil-insert-state-exit-hook
               'wox-save-buffer-has-file))
;;* LOCAL
(defun wox-save-local-p ()
  "Returns to true if wox-save-local is on."
  (equal t wox--save-local-p))

(defun wox-save-local-p-message ()
  "Print message if wox-save-local is on."
  (interactive)
  (if (wox-save-local)
      (message "wox-save-local is on")
    (message "wox-save-local is off")))

(defun wox-save-local-toggle ()
  "Toggle buffer save on exit insert mode, locally."
  (interactive)
  (if (wox-save-local-p)
      (wox-save-local-disable)
    (wox-save-local-enable)))

(defun wox-save-local-enable ()
  "Enable buffer save on exit insert mode, locally."
  (interactive)
  (wox-save-global-disable)
  (setq-local wox--save-local-p t)
  (add-hook 'evil-insert-state-exit-hook
            'wox-save-buffer-has-file nil t))

(defun wox-save-local-disable ()
  "Disable buffer save on exit insert mode, locally."
  (interactive)
  (setq-local wox--save-local-p -1)
  (remove-hook 'evil-insert-state-exit-hook
               'wox-save-buffer-has-file t))

(defun wox--lighter ()
  (concat
   (when (or (wox-save-local-p)
             (wox-save-global-p)) 
     " wox")
   (when (wox-save-global-p) "-G")
   (when (wox-save-local-p) "-L")))

(define-minor-mode wox-mode
  "Save buffer on leaving insert mode"
  :global t
  :lighter (:eval (wox--lighter)))

(provide 'wox)
;;; wox.el ends here
