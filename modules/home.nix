{ ... }: {
  programs.home-manager.enable = true;
  home.username = "gkiviv";
  home.homeDirectory = "/home/gkiviv";
  home.stateVersion = "23.11";

  programs.git = {
    enable = true;
    userName = "gkiviv";
    userEmail = "georgkivivali7@gmail.com";
  };
  home.file = { ".config/nvim/".source = ../programs/nvim; };
}
