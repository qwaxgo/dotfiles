{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "qwaxgo";
    userEmail = "qwaxgo@gmail.com";
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    extensions = with pkgs; [gh-markdown-preview]; # オススメ
    settings = {
      editor = "nvim";
    };
  };
}
