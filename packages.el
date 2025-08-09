;; -*- no-byte-compile: t; -*-

(package! evil-collection)
(package! gruvbox-theme)
(package! mu)
;; (package! caledonia
;;   :recipe (:host github
;;            :repo "RyanGibb/caledonia"
;;            :files ("emacs/*.el")))
(package! caledonia
  :recipe (:local-repo "/home/ryan/projects/caledonia"
           :files ("emacs/*.el")))
