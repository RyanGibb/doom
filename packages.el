;; -*- no-byte-compile: t; -*-

(package! evil-collection :pin "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0")
(package! gruvbox-theme)
(package! mu)
;; (package! caledonia
;;   :recipe (:host github
;;            :repo "RyanGibb/caledonia"
;;            :files ("emacs/*.el")))
(package! caledonia
  :recipe (:local-repo "/home/ryan/projects/caledonia"
           :files ("emacs/*.el")))
