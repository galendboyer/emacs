;; rundll32 sysdm.cpl,EditEnvironmentVariables

(setq inhibit-startup-message t)
(setq default-directory "c:/users/galen/")

;; set PYTHONIOENCODING 'utf-8'
;; set PYTHONLEGACYWINDOWSSTDIO 'utf-8'

(setq browse-url-browser-function 'browse-url-generic       browse-url-generic-program "C:/Program Files/Google/Chrome/Application/chrome.exe")

(defun my-browse-tiktok (url)
  (interactive)
  (browse-url-generic (concat "https://www.tiktok.com/search?q=" url)))

(add-to-list 'load-path "c:/users/galen/EMACS")

(autoload 'visual-basic-mode "visual-basic-mode" "Visual Basic mode." t)
(push '("\\.\\(?:frm\\|\\(?:ba\\|cl\\|vb\\)s\\)\\'" . visual-basic-mode)
      auto-mode-alist)

(tool-bar-mode -1)
(setq save-abbrevs t)
(setq-default abbrev-mode t)
(global-set-key (kbd "\C-ct") 'toggle-truncate-lines)
(global-set-key (kbd "\C-cl") 'display-line-numbers-mode)
(global-unset-key (kbd "\C-z"))
(global-unset-key (kbd "\C-x C-c"))

(require 'dired-x)

(setq-default indent-tabs-mode nil)
(put 'narrow-to-region 'disabled nil)


(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(require 'ibuffer)
(global-set-key "\C-x\M-b" 'ibuffer)

(show-paren-mode 1)

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("shell" (or
			 (name . "\\.cmd$")
                         (mode . comint-mode)
			 (mode . shell-mode)
                         (mode . eshell-mode)))
               ("sql" (or
                         (name . "\\.sql$")))
               ("python" (or
                          (name . "\\.py$")))
               ("raw" (or
			(name . "\\.csv$")
			(name . "\\.out$")
                        (name . "\\.txt$")))
               ("dired" (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
			 (name . ".emacs")))
               ))))



(defun my-start-command-shell()
    (interactive)
    (start-process-shell-command (format "cmd(%s)" default-directory) nil "start cmd"))


(defun my-list-of-gcp-sbx-projects()
  (interactive)
  (completing-read "Prompt: "
                   '("broadie-sbx-gboyer-edm-01"
                     "broadie-sbx-tkahura-edm-01"
                     "broadie-sbx-brichman-edm-01"
                     "broadie-sbx-gbernard-edm-01"
                     "broadie-sbx-schoudha-01"
                     "broadie-sbx-tkota-edm-01")))

(defun get-all-buffer-directories ()
  "Return a list of all directories that have at least one file
being visited."
  (interactive)
  (let (l)
    (dolist (e (sort (mapcar 'file-name-directory
                             (cl-remove-if-not 'identity
                                               (mapcar 'buffer-file-name
                                                       (buffer-list))))
                     'string<))
      (unless (string= (car l) e)
        (setq l (cons e l))))
    l))

(defun ibuffer-set-filter-groups-by-directory ()
  "Set the current filter groups to filter by directory."
  (interactive)
  (setq ibuffer-filter-groups
        (mapcar (lambda (dir)
                  (cons (format "%s" dir) `((directory . ,dir))))
                (get-all-buffer-directories)))
  (ibuffer-update nil t))

(define-key ibuffer-mode-map
  (kbd "/ D") 'ibuffer-set-filter-groups-by-directory)


(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
