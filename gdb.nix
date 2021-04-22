{ lib, stdenv
, python3
, fetchFromGitHub
, makeWrapper
, gdb
}:

let
  pythonPath = with python3.pkgs; makePythonPath [
    future
    isort
    psutil
    pycparser
    pyelftools
    python-ptrace
    ROPGadget
    six
    unicorn
    pygments
  ];

in stdenv.mkDerivation rec {
  name = "gdb-with-plugins";

  src = fetchFromGitHub {
    owner = "pwndbg";
    repo = "pwndbg";
    # https://github.com/pwndbg/pwndbg/commit/87da998fcefe8cba85f51dba0056b923483c6c1c
    rev = "87da998fcefe8cba85f51dba0056b923483c6c1c"; # 2021-04-21
    sha256 = "1akik9crz01bzkjalh5f3lzkz8zrbhgmf2m0sj7j77r82gr806bb";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/pwndbg
    cp -r *.py pwndbg $out/share/pwndbg
    chmod +x $out/share/pwndbg/gdbinit.py
    makeWrapper ${gdb}/bin/gdb $out/bin/gdb \
      --add-flags "-q -x $out/share/pwndbg/gdbinit.py" \
      --set NIX_PYTHONPATH ${pythonPath}
  '';
}
