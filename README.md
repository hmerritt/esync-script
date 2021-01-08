# Esync.sh

[![Build Status](https://travis-ci.org/hmerritt/esync-script.svg?branch=master)](https://travis-ci.org/hmerritt/esync-script)

A simple script that makes `rsync` super simple.




## Getting Started


### Install Dependencies
Install script dependencies via `install` argument.

```bash
$ sudo ./esync.sh install
```


#### Bash on Windows
Thanks to `WSL`, you can run bash scripts on windows!

- [Enable WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10)




## Usage

```bash
$ ./esync.sh <local-file-path> <remote-address OR alias> <remote-file-path>

$ ./esync.sh cat.jpg admin@example.com /home/admin/images
```

### Config
Create config via `init` argument.

```bash
$ sudo ./esync.sh init
```

#### Add server aliases
Server aliases are custom names for a server address

```bash
esync.sh cat.jpg myserver /home/admin/images

-->

esync.sh cat.jpg admin@example.com /home/admin/images
```

1. Open up the `esync.config` in `~/.config/esync.config`
2. Add the following line

```bash
ESYNC_ADDRESS=$(sshalias "${ESYNC_ADDRESS}" "myserver" "admin@example.com")

ESYNC_ADDRESS=$(sshalias "${ESYNC_ADDRESS}" "anotherserver" "root@amazingserver.com")

                                             ^^ alias        ^^ full server address
```
You can add as many aliases as you like (just add another line with a different alias)
