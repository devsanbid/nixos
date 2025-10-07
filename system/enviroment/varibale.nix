{ pkgs, ... }: {
  # environment.etc = {
  #   "resolv.conf".text = "nameserver 1.1.1.1\n";
  # };
  ## Enviroment varibale
  environment.sessionVariables = {
    FLAKE = "/home/sanbid/.dotfiles";
  };

}

