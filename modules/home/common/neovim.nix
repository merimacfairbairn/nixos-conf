{ inputs, pkgs, ... }:

{
  programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      waylandSupport = true;
  };

  xdg.configFile."nvim" = {
      source = inputs.nvim-config;
      recursive = true;
  };
}
