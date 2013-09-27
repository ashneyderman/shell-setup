(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\M-?" 'help-command)
(global-set-key "\C-z" 'other-window)
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode t)
(set-background-color "black")
(set-foreground-color "white")

;; Erlang mode R16B01
(setq load-path (cons "/usr/local/erlang/R16B01/lib/tools-2.6.11/emacs" load-path))
(setq erlang-root-dir "/usr/local/erlang/R16B01")
(setq exec-path (cons "/usr/local/erlang/R16B01/bin" exec-path))
(require 'erlang-start)

;; Distel extension
(setq load-path (cons "~/.emacs.d/plugins/distel/elisp" load-path))
(require 'distel)
(distel-setup)

;; Elixir mode
(setq load-path (cons "~/.emacs.d/plugins/emacs-elixir" load-path))
(require 'elixir-mode)

;; Markdown mode
(setq load-path (cons "~/.emacs.d/plugins/markdown-mode" load-path))
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(setq exec-path (cons "/usr/bin" exec-path))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-command "/usr/bin/marked"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)

;; emacs-git
(setq load-path (cons "~/.emacs.d/plugins/git-emacs" load-path))
(require 'git-emacs)

;; Make a copy of the current line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)
(global-set-key (kbd "C-d") 'duplicate-line)

;; Bringing up ansi-term with F2
(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
(global-set-key (kbd "<f2>") 'visit-ansi-term)

(defun other-window-backwards () 
   "Select previous window"
   (interactive)
   (other-window -1))
(global-set-key "\C-x\C-p" 'other-window-backwards)
(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
