;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Ryan Gibb"
      user-mail-address "ryan@freumh.org")

(load! "appearance.el")
(load! "mu4e.el")
(load! "ledger.el")

(setq org-directory "~/vault/")
(setq which-key-idle-delay 0.01)

;; https://github.com/doomemacs/doomemacs/issues/8101
;; (map! :m "TAB" #'evil-jump-forward)
;; (after! evil-org
;;         (setq evil-want-C-i-jump nil)
;; )

;; https://discourse.doomemacs.org/t/permanently-display-workspaces-in-minibuffer/84
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;; https://github.com/doomemacs/doomemacs/issues/3151
(map! :map evil-ex-completion-map
      "C-f" #'evil-command-window
      :map evil-ex-search-keymap
      "C-f" #'evil-command-window)
(setq evil-collection-setup-minibuffer t)
