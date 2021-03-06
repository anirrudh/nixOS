# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

    boot.initrd.availableKernelModules = [ "amdgpu" "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fd98c434-3413-4ccc-83cc-860845cd3ba5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F2D2-35DF";
      fsType = "vfat";
    };
  
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/48276bb0-1b85-4cda-9a07-052d201a4243";
    fsType = "ext4";
  };

#  fileSystems."/data/hyperloop" = {
#    device = "192.168.1.134:/mnt/hyperloop";
#    fsType = "nfs";
#  };

swapDevices = [
  { device = "/swap"; size = 4096; }
];

  nix.maxJobs = lib.mkDefault 24;
}
