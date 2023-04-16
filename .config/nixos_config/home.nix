{ config, pkgs, ... }:
{
  home.username = "jelgar";
  home.homeDirectory = "/home/jelgar";
  home.stateVersion = "23.05";
  
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ tmux tlp exa nodejs ];

  programs.git = {
    enable = true;
    userName = "jelgar";
    userEmail = "jamesnelgar@gmail.com";
  };

  programs.zsh = {
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };
}
