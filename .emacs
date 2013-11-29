;; .emacs
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/cedet-1.1/common/")
;; tool-bar-mode
(tool-bar-mode -1)
;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
(require 'xcscope)

(require 'color-theme)
(color-theme-initialize)
(color-theme-ld-dark)

(setq frame-title-format `("%s" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("mepla" . "http://mepla.milkbox.net/packages/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'auto-mode-alist  '("\\.py\\'" . python-mode))


(require 'auto-complete-config)
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(require 'auto-complete-clang-async)
;; for c/c++ tab/indent
(defun c-common-style ()
  (setq default-tab-width 4)
  (setq-default indent-tabs-mode nil)
;  (setq c-default-style "linux" c-basic-offset 4)
)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
  (define-key c-mode-base-map (kbd "<f7>") 'compile)
  (c-common-style)
)
(defun ac-c++-mode-setup ()
  (ac-cc-mode-setup)
)

 ; echo "" | g++ -v -x c++ -E -
(defun my-ac-config ()
  (setq ac-clang-flags
        (mapcar( lambda(item)(concat "-I" item)) (split-string
                                              "/usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2
/usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/x86_64-redhat-linux
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/../../../../include/c++/4.1.2/backward
 /usr/local/include
 /usr/lib/gcc/x86_64-redhat-linux/4.1.2/include
 /usr/include

")))
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
 ; (add-hook 'c-mode-hook 'ac-cc-mode-setup)
 ;(add-hook 'c++-mode-hook 'ac-c++-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t)
)
(my-ac-config)
