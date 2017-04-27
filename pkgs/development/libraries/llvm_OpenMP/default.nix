{stdenv fetchgit cmake gnumake perl}:

stdenv.mkDerivation rec {
  name = "openmp-${version}";
  version = "24.6.17";

  src = fetchgit  {
    url = "http://llvm.org/git/openmp";
    rev = "81a7c91728a2c763d6ecbb9374a0bbf413e43ac4";
#date: "2017-04-25T19:04:07+00:00";
    sha256  = "06641656wckpg4va1fn1dz3b6irr525vw699qallhf095h16gskm";
    fetchSubmodules =  true;
  };

  buildInputs = [ cmake gnumake perl];

  meta = {
    description = "The OpenMP subproject of LLVM contains the components required to build an executable OpenMP program that are outside the compiler itself. ";
    homepage = http://openmp.llvm.org/;
  };
}

