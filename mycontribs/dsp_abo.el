;; -*- coding:utf-8-unix mode:emacs-lisp -*-
;;***************************************************************************************
;;
;; 2016-2019 Totok Sulistiomono
;; stotok@kukisku.com
;;
;;***************************************************************************************

;;
;; ivy
;;      http://oremacs.com/2016/04/26/ivy-0.8.0
;;
;; a completion method that's similar to 'ido', but with emphasis on simplicity
;; and customizability. ivy cannot live together with 'ido', so choose one.
;;
;; Other packages that can use ivy completion:
;; - find-file-in-project
;; - projectile
;; - etc (check github)
(cond
 ((IsDspUserConfig)
  (when (configuration-layer/package-usedp 'ivy)
    (message "*** dsp_abo.el user config: ivy customization")
    ;;
    (setq ivy-use-virtual-buffers t     ; add recent files and bookmarks to the ivy-switch-buffer
          ivy-height 12
          ivy-count-format "(%d/%d)"    ; display the current and total number in the collection
          ivy-display-style 'fancy)
    ;;
    ;; i don't like dir buffer. let's change some :)
    (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)
    ;;
    ;; ripgrep, see: https://oremacs.com/2018/03/05/grep-exclude/
    ;;
    (cond                               ; please install ripgrep
     ((or (IsOSX) (IsGNULinux))         ; $ sudo port install ripgrep
      (setq counsel-git-cmd "rg --files")
      (setq counsel-rg-base-command
            "rg -i -M 120 --no-heading --line-number --color never %s .")
      ;; https://oremacs.com/2017/08/04/ripgrep/
      (setq counsel-grep-base-command
            "rg -i -M 120 --no-heading --line-number --color never '%s' %s")
      )
     )
    )
  )
 )

;;
;; swiper
;;     https://github.com/abo-abo/swiper.git
;;
;; Overview as you search for a regex.
;;
;; It also provides 'ivy-mode', where emacs requires completion, like:
;; M-x     execute-extended-command
;; C-h f   describe-function
;; C-h v   describe-variable
;; package-install
;; C-x b   switch-to-buffer (now used for 'projectile-switch-to-buffer)
;; C-x C-f find-file
(cond
 ((IsDspUserConfig)
  (when (configuration-layer/package-usedp 'swiper)
    (message "*** dsp_abo.el user config: swiper customization")
    ;; simulate "*" in vim with a better swiper interface
    (when nil                             ; let's see first
      (define-key evil-normal-state-map (kbd "*")
        (lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'symbol)))))
      (define-key evil-normal-state-map (kbd "#")
        (lambda () (interactive) (swiper (format "\\<%s\\>" (thing-at-point 'word))))))

    ;; search or swipe for the current word (another way)
    ;; i.e. after start swiper, use M-j or M-n (with ivy)

    ;; advise swiper to recenter on exit
    ;;     http://pragmaticemacs.com/emacs/dont-search-swipe/
    (defun bjm-swiper-recenter (&rest args)
      "recenter display after swiper"
      (recenter))
    (advice-add 'swiper :after #'bjm-swiper-recenter))
  )
 )

;; EOF
