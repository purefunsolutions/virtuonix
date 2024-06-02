# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# Packages to be exported from the flake
{
  perSystem = {pkgs, ...}: {
    packages = let
      virtuonix = pkgs.callPackage ../virtuonix {};
      default = virtuonix;
    in {
      inherit default virtuonix;
    };
  };
}
