HAXELIB-SHELL-COMPLETION
========================
Shell completion for haxelib and libraries (currently linux only).


### Install
Make sure $HAXELIB environment variable is set
```sh
git clone https://github.com/tong/haxelib-shell-completion
cd haxelib-shell-completion

# Build and install as haxelib
make install

# Install wrapper script (normally /etc/bash_completion.d or /etc/profile.d)
sudo cp res/haxelib-completion.sh /etc/bash_completion.d/haxelib

# To test completion open a new shell or run
source /etc/bash_completion.d/haxelib
```


### Usage
```sh
$ haxelib ⇥⇥
config      install     proxy       search      submit      
dev         list        register    selfupdate  update      
git         local       remove      set         upgrade     
info        path        run         setup       user
```

```sh
$ haxelib li⇥⇥ # Completes 'list'
$ haxelib list
$ haxelib list ⇥⇥ # Completes installed libraries
box2d
cocktail
flixel
format
hscript
hxargs
hxcpp
hxmpp
hxparse
hxssl
inotify
inotify
systools
tora
tora
```

```sh
$ haxelib r⇥⇥
register  remove    run       
$ haxelib ru⇥
$ haxelib run ⇥⇥ # Completes runable libraries (providing run.n)
flixel
hxcpp
tora
```

```sh
$ haxelib local ⇥ # Completes with *.zip files
$ haxelib local mylib.zip
```
