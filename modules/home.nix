{ inputs, pkgs, ... }: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  # nixpkgs.config.allowUnfree = true;
  home-manager.users.gkiviv = {

    home.username = "gkiviv";
    home.homeDirectory = "/home/gkiviv";
    home.stateVersion = "23.11";

    programs.git = {
      enable = true;
      userName = "gkiviv";
      userEmail = "georgkivivali7@gmail.com";
      lfs.enable = true;
    };

    programs.neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };
        
    programs.vscode = {
        enable = true;       
        package = pkgs.vscode.fhs;
    };

        
    home.file = { ".config/nvim/".source = ../programs/nvim; };
  };
}
