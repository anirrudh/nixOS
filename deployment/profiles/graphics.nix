{ config, pkgs, ...}:

{
  # Enable openGL
  hardware.opengl.enable = true; 
  hardware.opengl.driSupport32Bit = true; 
  
  # Install packages for graphics
  environment.systemPackages = with pkgs; [
    cudatoolkit
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    vulkan-tools
  ];
}



