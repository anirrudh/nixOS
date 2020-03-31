{
  network = {
    description = "Lara";
    enableRollback = true;
  };

  Lara = {
    deployment.targetHost = "localhost";
  
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
};
}
