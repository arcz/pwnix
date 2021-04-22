{ lib
, stdenv
, buildPythonPackage
, fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "vmlinux-to-elf";
  version = "6225011-master";

  doCheck = false;

  # https://github.com/marin-m/vmlinux-to-elf
  src = fetchFromGitHub {
    owner = "marin-m";
    repo = "vmlinux-to-elf";
    rev = "62250118ef63991f1503cb71d6ed114d3b5524d3";
    sha256 = "1m4i5r06larp76cp4ca3y9vfdgj05g3hbnxiqpa7vrmzlrhdi0yd";
  };
}
