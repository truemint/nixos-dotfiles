# Truemint's NixOS Configuration

## Additional Instructions

Most of the system setup should be handled declaratively by the configuration in this repo. There are a few things which need to be set up imperatively:

- *Maestral:* [Maestral](https://maestral.app) is an open-source client for Dropbox. Maestral requires write access to it's config file. Additionally, it's documentation specifically states that it's config should not be manually updated because changes to it's settings require Maestral to perform accompanying actions like syncing or deleting files. Therefore, the config for Maestral is intentionally not managed declaratively through.

- KeepassXC

- NeoVim
