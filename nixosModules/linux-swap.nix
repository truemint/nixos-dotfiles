# Linux Swap config
{
  config,
  pkgs,
  ...
}: {
  # Set Swap options
  # zramSwap enables ZRAM for high-speed compressed swap
  # swapDevices enable a swap file as a safety net in case ZRAM runs out
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25; # Max size of the ZRAM device
    priority = 100; # Higher priority than swap file means it's used first
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8192; # 8GB in MB
      priority = 10; # Lower priority than zramSwap means it's used only when ZRAM is full
    }
  ];

  # Tells Linux kernel to make good use of the ZRAM swap
  boot.kernel.sysctl = {"vm.swapiness" = 60;};
}
