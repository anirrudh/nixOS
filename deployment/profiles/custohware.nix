{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    libratbag     # cool mouse support
    piper         # gui for ratbagd
  ];

  services.dbus.packages = [ pkgs.libratbag ];
  systemd.packages = [ pkgs.libratbag ];
}
  
