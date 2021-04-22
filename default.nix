let pkgs = import <nixpkgs> {};
    gdbWithPlugins = pkgs.callPackage (import ./gdb.nix) {};
    pythonWithPackages = pkgs.python3.withPackages(p: with p; [
      ipython
      pwntools
      ropper
    ]);
in
with pkgs;
pkgs.buildEnv {
  name = "pwnix";
  paths = [
    gdbWithPlugins
    pythonWithPackages
    one_gadget
  ];
}
