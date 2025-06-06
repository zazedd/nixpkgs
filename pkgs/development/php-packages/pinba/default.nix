{
  buildPecl,
  lib,
  fetchFromGitHub,
}:

buildPecl rec {
  pname = "pinba";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "tony2001";
    repo = "pinba_extension";
    rev = "RELEASE_${lib.replaceStrings [ "." ] [ "_" ] version}";
    sha256 = "0wqcqq6sb51wiawa37hbd1h9dbvmyyndzdvz87xqji7lpr9vn8jy";
  };

  # Fix GCC 14 build.
  # from incompatible pointer type [-Wincompatible-pointer-types
  env.NIX_CFLAGS_COMPILE = "-Wno-error=incompatible-pointer-types";

  meta = with lib; {
    description = "PHP extension for Pinba";
    longDescription = ''
      Pinba is a MySQL storage engine that acts as a realtime monitoring and
      statistics server for PHP using MySQL as a read-only interface.
    '';
    license = licenses.lgpl2Plus;
    homepage = "http://pinba.org/";
    teams = [ teams.php ];
  };
}
