;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ryan Gibb"
      user-mail-address "ryan@freumh.org")

(load! "appearance.el")
(load! "mu4e.el")
(load! "ledger.el")
(load! "org.el")

(setq which-key-idle-delay 0.1)

;; https://github.com/doomemacs/doomemacs/issues/8101
;; (map! :m "TAB" #'evil-jump-forward)
;; (after! evil-org
;;         (setq evil-want-C-i-jump nil)
;; )

;; https://github.com/doomemacs/doomemacs/issues/3151
(map! :map evil-ex-completion-map
      "C-f" #'evil-command-window
      :map evil-ex-search-keymap
      "C-f" #'evil-command-window)
(setq evil-collection-setup-minibuffer t)

(global-set-key (kbd "<mouse-8>") #'evil-jump-backward)
(global-set-key (kbd "<mouse-9>") #'evil-jump-forward)

;; https://evil.readthedocs.io/en/latest/faq.html#underscore-is-not-a-word-character
(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'rust-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'emacs-lisp-mode-hook #'(lambda () (modify-syntax-entry ?- "w")))
(add-hook 'conf-toml-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(after! lsp-mode
  ;; https://github.com/emacs-lsp/lsp-mode/issues/713#issuecomment-985653873
  (advice-add 'lsp--get-ignored-regexes-for-workspace-root
              :around (lambda (fn workspace-root)
                        (let* ((ignored-things (funcall fn workspace-root))
                               (ignored-files-regex-list (car ignored-things))
                               (ignored-directories-regex-list (cadr ignored-things))
                               (cmd (format "git clean --dry-run -X '%s' | cut -d' ' -f3" workspace-root))
                               (gitignored-things (split-string (shell-command-to-string cmd) "\n" t))
                               (gitignored-files (seq-remove (lambda (line) (string-match "[/\\\\]\\'" line)) gitignored-things))
                               (gitignored-directories (seq-filter (lambda (line) (string-match "[/\\\\]\\'" line)) gitignored-things))
                               (gitignored-files-regex-list
                                (mapcar (lambda (file) (concat "[/\\\\]" (regexp-quote file) "\\'"))
                                        gitignored-files))
                               (gitignored-directories-regex-list
                                (mapcar (lambda (directory)
                                          (concat "[/\\\\]"
                                                  (regexp-quote (replace-regexp-in-string "[/\\\\]\\'" "" directory))
                                                  "\\'"))
                                        gitignored-directories)))
                          (list
                           (append ignored-files-regex-list gitignored-files-regex-list)
                           (append ignored-directories-regex-list gitignored-directories-regex-list))))))
