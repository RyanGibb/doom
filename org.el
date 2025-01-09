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
           "* TODO %?\n%i\n" :prepend t)
          ("n" "Note" entry
           (file +org-capture-notes-file)
           "* %u %? %i\n" :prepend t)
          ("l" "Link note" entry
           (file +org-capture-notes-file)
           "* %?\n%a" :prepend t)
          ("j" "Journal" entry
           (file+olp+datetree +org-capture-journal-file)
           "* %U %?\n%i"))
  )
  (setq org-tag-alist '(("work" . ?w) ("systems" . ?s)))
  (defun org-todo-list-work ()
    "Run org-todo-list and filter by tag w."
    (interactive)
    (progn
      (org-todo-list nil)
      (org-agenda-filter-by-tag nil ?w nil)))
  (map! :leader
      :desc "Org Agenda List" "A" #'org-agenda-list
      :desc "Org Todo List" "T" #'org-todo-list
      :desc "Org Todo List Work" "W" #'org-todo-list-work)
)

(defun convert-markdown-to-org-with-pandoc-and-delete ()
  "Convert the current Markdown file to an Org file using Pandoc and delete the original."
  (interactive)
  (when (and buffer-file-name
             (string-equal (file-name-extension buffer-file-name) "md"))
    (let* ((org-file (concat (file-name-sans-extension buffer-file-name) ".org"))
           (command (format "pandoc -f markdown -t org %s -o %s --wrap=none"
                            (shell-quote-argument buffer-file-name)
                            (shell-quote-argument org-file))))
      (save-buffer)
      (if (eq (call-process-shell-command command) 0)
          (progn
            (find-file org-file)
            (message "Converted %s to %s." buffer-file-name org-file))
        (message "Pandoc conversion failed!")))))

(map! :leader
      :desc "Convert Markdown to Org with Pandoc and delete"
      "f M" #'convert-markdown-to-org-with-pandoc-and-delete)
