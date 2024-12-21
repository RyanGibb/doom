;;; ledger.el -*- lexical-binding: t; -*-

(after! ledger
  (setq ledger-post-amount-alignment-column 52)
  (setq ledger-default-date-format ledger-iso-date-format)
  (setq ledger-post-account-alignment-column 4)
  (setq ledger-reconcile-default-commodity '£)
  (setq tab-always-indent 'complete)
)
