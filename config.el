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
