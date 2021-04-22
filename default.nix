let pkgs = import <nixpkgs> {};
    gdbWithPlugins = pkgs.callPackage (import ./gdb.nix) {};
    pythonWithPackages = pkgs.python3.withPackages(p: with p; [
      ipython
      pwntools
      ropper
    ]);
    vmlinux-to-elf = pkgs.python3Packages.callPackage (import ./vmlinux-to-elf.nix) {};
in
with pkgs;
pkgs.buildEnv {
  name = "pwnix";
  paths = [
    gdbWithPlugins
    pythonWithPackages
    one_gadget
    vmlinux-to-elf
  ];
}
