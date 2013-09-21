
HAXELIB-SHELL-COMPLETION
========================
Shell completion for haxelib and haxelib libraries
Currently linux only.


#### Install

# Make sure your $HAXELIB variable is set
$ git clone https://github.com/tong/haxelib-shell-completion
$ cd haxelib-shell-completion
$ make install
$ sudo haxelib run shell-completion install

To test tab completion open a new shell (or source /etc/bash_completion.d/haxelib).


#### Usage

$ haxelib ⇥⇥
config      install     proxy       search      submit
dev         list        register    selfupdate  update
git         local       remove      set         upgrade
info        path        run         setup       user

$ haxelib li⇥⇥
tora: [1.8.1]
hxssl: [3.0.0-alpha]
hxargs: [1.0.0]
hxtemplo: [1.0.0-alpha.2]
nekoboot: [1.0.0-alpha]
mtwin: [1.6.0]
hscript: [2.0.1]
ogl: [0.2.0]
format: [3.0.2]
hxcpp: 3.0.2 [svn]
hxmpp: 0.4.12 [0.4.12]
...

## Haxelibs 'local' command is used to install a lokal haxelib.zip package (without submitting to the central repository)
## As haxelib only accepts .zip files it will only suggest completion for such in the current filpath
$ haxelib lo⇥⇥
$ haxelib local⇥ 
$ haxelib local mylib.zip (Assuming mylib.zip is the only zip file in wd)

And so on ..