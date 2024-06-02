# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# NixOS Modules to be exported from the flake
_: {
  flake.nixosModules = {
    host.imports = [./host];
  };
}
