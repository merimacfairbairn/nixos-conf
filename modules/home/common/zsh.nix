{
  pam.sessionVariables = {
    EDITOR="nvim";
  };

  programs.zsh = {
    enable = true;

    shellAliases = {
      ll = "ls -alh";
      la = "ls -Al";
      nrs = "sudo nixos-rebuild switch";
    };
    
    history = {
      size = 10000;
      save = 10000;
      share = true;
    };
  };
}
