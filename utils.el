;;; utils.el --- Utils extensions with useful editor commands.
;;; Commentary:
;;; Miscellaneous editor functions such as OS commands and
;;; other useful stuff.
;;;
;;; Code:
(defun open-here ()
  "Open current directory in file manager."
  (interactive)
  (shell-command "open ."))

(provide 'utils)
;;; utils.el ends here
