{ inputs, pkgs, ... }:

{
  programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.neovim;
  };

  xdg.configFile."nvim" = {
      source = inputs.nvim-config;
      recursive = true;
  };
}
