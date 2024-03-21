{pkgs, config, lib ...}:
let
    emacs = pkgs.emacsWithPackagesFromUsePackage {
        package = pkgs.emacs-gtk;
        config = ./init.el;
        extraEmacsPackages = epkgs: with epkgs; [
          use-package
          # bbdb
          # org-mime
          # bind-key
        ];
        alwaysEnsure = true;
        alwaysTangle = true;
      };
in {
        
}
