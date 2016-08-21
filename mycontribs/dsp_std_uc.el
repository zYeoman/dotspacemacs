;; -*- coding:utf-8-unix mode:emacs-lisp -*-
;;***************************************************************************************
;;
;; 2016 Totok Sulistiomono
;; stotok@kukisku.com
;;
;;***************************************************************************************
;;
;; **************************************************************************************
;; For/from standard emacs/spacemacs distribution
;; This file is supposed to be called from
;;    dontspacemacs/user-config
;; **************************************************************************************

;; ************************************************************************************
;;
;; Here for emacs standard stuffs
;;
;; ************************************************************************************
;;
;; Enable utf coding
;;
;; disable CJK coding/encoding (chinese/japanese/korean characters)
(setq utf-translate-cjk-mode nil)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
;; set the default encoding system
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2
(if (boundp buffer-file-coding-system)
    (setq buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
;; Treat clipboard input as UTF-8 string first; compound text next, etc
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; Depend on the font size, sometimes frame size cannot be maximized (there's ugly gap)
(setq frame-resize-pixelwise t)
;;
;; Frame title bar formatting to show full path of file
;;
(setq-default
  frame-title-format
  (list '((buffer-file-name " %f" (dired-directory
                                  dired-directory
                                  (refert-buffer-function " %b"
                                                          ("%b - Dir: " default-directory)))))))
;;
(setq-default indent-tabs-mode nil) ; use spaces (not tabs) for indenting
(setq-default truncate-lines t)     ; turn on truncating long lines
(setq require-final-newline t)      ; always add a final newline
(set-fringe-mode '(0 . 0))          ; disable fringe, dun need it (no line wrap, etc)
;; i dun want horizontal window splitting
;; and i want only vertical window splitting
(setq split-height-threshold 0)
(setq split-width-threshold nil)
;; vi like scrolling
(setq scroll-step 1           ; scroll just goes down 1 line even it hits the bottom
      scroll-margin 3)        ; 3 lines margin
;;
;; turn-on automatic bracket insertion by pairs. New in emacs 24
;;
(when t
  (electric-pair-mode t)
  ;; make electric-pair-mode work on more brackets
  ;; e.g. curly bracket {} isn't auto-closed when in emacs-lisp-mode
  (setq electric-pair-pairs '(
                              (?\" . ?\")
                              (?\{ . ?\})
                              ))
  ;; LaTeX-mode
  (add-hook 'LaTeX-mode-hook
            '(lambda ()
                ;; removes TeX-insert-dollar binding to $ and somehow (electric-pair-mode)
                ;; takes over and realises that $ is a bracket in this context.
                ;; http://tex.stackexchange.com/questions/75697/auctex-how-to-cause-math-mode-dollars-to-be-closed-automatically-with-electric
                (define-key LaTeX-mode-map (kbd "$") 'self-insert-command))))
;;
;; ************************************************************************************
;;
;; Here for evil/spacemacs behaviour
;;
;; ************************************************************************************
;; Stop Cursor Creep. Does it bother you that the cursor creeps back when you
;; go back to normal mode? Here's how to stop it.
;; With this setting, command '$' in normal mode will bring cursor go pass the
;; end of line (just like emacs behaviour).
;; Wait ... I think cursor creep is the way to go. Keep it creep :)
(setq evil-move-cursor-back t)
(spacemacs/toggle-vi-tilde-fringe-off) ;; don't want tilde on empty lines
;; ivy-mode: well, i don't like dir buffer. let's change :)
(define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)

;; EOF