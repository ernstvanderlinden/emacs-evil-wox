Emacs - wox
==============
Emacs package to write on exit insert mode. 

Install
-------
#### Clone
As this package is not on [Melpa](https://melpa.org) (yet), clone this repo and call ```package-install-file``` or simply add a ```load-path``` which points to **wox** local repo. If you prefer, you could use [quelpa](https://github.com/quelpa/quelpa) as well.

#### Startup
To enable **wox** on Emacs startup, add the following to your init.el:

```elisp
(require 'wox)
;; enable globally on emacs startup
;; (wox-save-global-enable)
```

#### Dependency
This package depends on [evil](https://melpa.org/#/evil), so please make sure that has been installed as well.

Usage
-----

#### Interactive functions
- M-x ```wox-save-global-toggle```
- M-x ```wox-save-global-enable```
- M-x ```wox-save-global-disable```
- M-x ```wox-save-local-toggle```
- M-x ```wox-save-local-enable```
- M-x ```wox-save-local-disable```

#### Example 1 - enable globally
```elisp
(wox-save-global-enable)
```
#### Example 2 - binding to toggle
```elisp
(global-set-key (kbd "C-c C-w") 'wox-save-local-toggle)
```
```
