# Boot settings
{
  config,
  pkgs,
  flakeInputs,
  ...
}: {
  imports = [
    # Import catppuccin/nix module for styling GRUB
    flakeInputs.catppuccin.nixosModules.catppuccin
  ];

  # Enable Catppucin theme for GRUB
  catppuccin.grub = {
    enable = true;
    flavor = "mocha";
  };

  boot = {
    # Supply monitor resolution to kernel so that boot screens do not look low-res / blurry
    kernelParams = ["video=3440x1440"];

    # Set boot loader options
    loader = {
      # When set to true, it allows NixOS to write to EFI variables, creating a "NixOS" entry in the UEFI boot menu
      efi.canTouchEfiVariables = true;

      grub = {
        # Enable GRUB boot loader
        enable = true;

        # Default boot should be into the last selected boot option
        default = "saved";

        # The special value nodev means that a GRUB boot menu will be generated, but GRUB itself will not actually be installed
        device = "nodev";

        # Build GRUB with EFI support
        efiSupport = true;

        # Append entries for other OSs detected by os-prober
        useOSProber = true;

        # Pass screen resolution to GRUB
        gfxmodeEfi = "3440x1440";
      };
    };
  };
}
