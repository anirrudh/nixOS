{
  network = {
    description = "Lara";
    enableRollback = true;
  };

  Lara = {
    deployment.targetHost = "localhost";
  
  imports = [
    ./conf/Lara/configuration.nix
    ./conf/Lara/hardware-configuration.nix
  ];
};
}
