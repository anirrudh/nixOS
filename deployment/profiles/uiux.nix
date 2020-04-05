{config, lib, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    arc-kde-theme # Theme for KDE
    latte-dock    # Linux dock-solution
    gnome3.adwaita-icon-theme # some apps still rely on gnome, k?
    papirus-icon-theme  # Icon theme of choice
  ];
}
