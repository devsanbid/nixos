{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "Anonymous";
  version = "1.1";

  # Replace this with the actual path to your Plymouth theme
  src = ./plymouth/Anonymous;

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/Anonymous
    cp -r * $out/share/plymouth/themes/Anonymous/
  '';

  meta = with lib; {
    description = " custom Plymouth theme";
    homepage = ""; # Optional: add your source/homepage if applicable
    license = licenses.free; # Replace with appropriate license
  };
}
