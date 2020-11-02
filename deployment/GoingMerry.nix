{
  network = {
    description = "GoingMerry";
    enableRollback = true;
  };

  GoingMerry = {
    deployment.targetHost = "192.168.1.137";
  
  imports = [
    ./conf/GoingMerry/configuration.nix
    ./conf/GoingMerry/hardware-configuration.nix
  ];
};
}
