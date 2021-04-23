let pkgs = import <nixpkgs> {};
    gdbWithPlugins = pkgs.callPackage (import ./gdb.nix) {};
    pythonWithPackages = pkgs.python3.withPackages(p: with p; [
      ipython
      pwntools
      ropper
    ]);
    vmlinux-to-elf = pkgs.python3Packages.callPackage (import ./vmlinux-to-elf.nix) {};
    onPath = with pkgs; [
      gdbWithPlugins
      pythonWithPackages
      one_gadget
      vmlinux-to-elf
      patchelf
    ];
in if pkgs.lib.inNixShell then
  pkgs.mkShell {
    buildInputs = onPath;
  }
else
  pkgs.buildEnv {
    name = "pwnix";
    paths = onPath;
  }
