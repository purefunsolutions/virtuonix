# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# virtuonix package
{rustPlatform}:
rustPlatform.buildRustPackage {
  pname = "virtuonix";
  version = "0.1.0";

  src = ./.;

  cargoLock.lockFile = ./Cargo.lock;
}
