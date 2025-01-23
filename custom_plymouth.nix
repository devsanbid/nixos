{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "main";
  version = "1.0";

  # Replace this with the actual path to your Plymouth theme
  src = ./plymouth/Anonymous;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/main
    cp -r * $out/share/plymouth/themes/main/
  '';

  meta = with lib; {
    description = " custom Plymouth theme";
    homepage = ""; # Optional: add your source/homepage if applicable
    license = licenses; # Replace with appropriate license
  };
}
