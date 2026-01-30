# Font configuration
{ pkgs, ... }: {

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      # Standard fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      comic-mono

      # Nerd Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      nerd-fonts.noto
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.iosevka
      nerd-fonts.sauce-code-pro
      nerd-fonts.victor-mono
      nerd-fonts.zed-mono
      nerd-fonts.go-mono
      nerd-fonts.commit-mono
    ];
  };
}
