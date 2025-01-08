;;; org.el -*- lexical-binding: t; -*-

(setq org-directory "~/vault/")

(use-package! org-habit :after org)

(after! org
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"    ; A task that needs doing & is ready to do
           "PROJ(p)"    ; A project, which usually contains other tasks
           "LOOP(r)"    ; A recurring task
           "STRT(s)"    ; A task that is in progress
           "WAIT(w)"    ; Something external is holding up this task
           "HOLD(h)"    ; This task is paused/on hold because of me
           "IDEA(i)"    ; An unconfirmed and unapproved task or notion
           "|"
           "DONE(d)"    ; Task successfully completed
           "KILL(k)"))) ; Task was cancelled, aborted, or is no longer applicable
  (setq +org-capture-notes-file (concat org-directory "/refile.org"))
  (setq +org-capture-todo-file (concat org-directory "/todo.org"))
  (setq +org-capture-journal-file (concat org-directory "/journal.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file +org-capture-todo-file)
           "* TODO %?\n%i\n")
          ("n" "Note" entry
           (file +org-capture-notes-file)
           "* %u %? %i\n")
          ("l" "Link note" entry
           (file +org-capture-notes-file)
           "* %?\n%a" :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i"))
  )
)

(defun convert-markdown-to-org-with-pandoc-and-delete ()
  "Convert the current Markdown file to an Org file using Pandoc and delete the original."
  (interactive)
  (when (and buffer-file-name
             (string-equal (file-name-extension buffer-file-name) "md"))
    (let* ((org-file (concat (file-name-sans-extension buffer-file-name) ".org"))
           (command (format "pandoc -f markdown -t org %s -o %s"
                            (shell-quote-argument buffer-file-name)
                            (shell-quote-argument org-file))))
      (save-buffer)
      (if (eq (call-process-shell-command command) 0)
          (progn
            (delete-file buffer-file-name)
            (kill-buffer (current-buffer))
            (find-file org-file)
            (message "Converted %s to %s using Pandoc and deleted the original file." buffer-file-name org-file))
        (message "Pandoc conversion failed!")))))

(map! :leader
      :desc "Convert Markdown to Org with Pandoc and delete"
      "f M" #'convert-markdown-to-org-with-pandoc-and-delete)
