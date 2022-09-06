{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    pwndbg-repo = { url = "github:pwndbg/pwndbg"; flake = false; };
  };

  outputs = { self, nixpkgs, flake-utils, pwndbg-repo }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          py = pkgs.python3.withPackages (p: with p; [
            ipython pwntools
            # pwndbg deps
            future isort psutil pycparser pyelftools python-ptrace
            ROPGadget six unicorn pygments
          ]);
      in {
        packages.pwndbg = pkgs.callPackage (import ./gdb.nix) { inherit pwndbg-repo; };
        devShells.pwndbg = pkgs.mkShell {
          buildInputs = with pkgs; [ gdb git py ];
          # gdb doesn't pick up our python with deps from path, set explicitly
          NIX_PYTHONPATH = "${py}/${py.sitePackages}";
        };
      }
    );
}
