# pwnix

Installation:

```sh
$ curl -L https://nixos.org/nix/install | sh # https://nixos.org/download.html
$ nix-env -f https://github.com/arcz/pwnix/tarball/main -i
```

## pwndbg development

With flakes enabled, you can get a shell with GDB configured with Python that
already has all the libraries needed by pwndbg.

```sh
nix develop github:arcz/pwnix#pwndbg
git clone git@github.com:pwndbg/pwndbg.git
echo "source $(pwd)/pwndbg/gdbinit.py" >> ~/.gdbinit
```
