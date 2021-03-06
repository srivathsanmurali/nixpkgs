{ stdenv, fetchFromGitHub, scons, pkgconfig, SDL, lua, fftwFloat, zlib, bzip2 }:

stdenv.mkDerivation rec {
  name = "the-powder-toy-${version}";
  version = "92.0.331";

  src = fetchFromGitHub {
    owner = "simtr";
    repo = "The-Powder-Toy";
    rev = "v${version}";
    sha256 = "185zlg20qk6ic9llyf4xka923snqrpdazg568raz0jiafzzsirax";
  };

  patches = [ ./fix-env.patch ];

  postPatch = ''
    sed -i 's,lua5.1,lua,g' SConscript
  '';

  nativeBuildInputs = [ scons pkgconfig ];

  buildInputs = [ SDL lua fftwFloat zlib bzip2 ];

  buildPhase = "scons DESTDIR=$out/bin --tool='' -j$NIX_BUILD_CORES";

  installPhase = ''
    install -Dm 755 build/powder* "$out/bin/powder"
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "A free 2D physics sandbox game";
    homepage = "http://powdertoy.co.uk/";
    platforms = platforms.unix;
    license = licenses.gpl3;
    maintainers = with maintainers; [ abbradar ];
  };
}
