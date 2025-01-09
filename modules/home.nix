{ inputs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager.users.gkiviv = {

    home.username = "gkiviv";
    home.homeDirectory = "/home/gkiviv";
    home.stateVersion = "23.11";

    programs.git = {
      enable = true;
      userName = "gkiviv";
      userEmail = "georgkivivali7@gmail.com";
    };

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };

    home.file = { ".config/nvim/".source = ../programs/nvim; };
  };
}
