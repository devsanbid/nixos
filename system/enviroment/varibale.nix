{ pkgs, ... }: {
  environment.etc = {
    "resolv.conf".text = "nameserver 1.1.1.1\n";
  };
  ## Enviroment varibale
  environment.sessionVariables = {
    FLAKE = "/home/sanbid/.dotfiles";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
  };

}

