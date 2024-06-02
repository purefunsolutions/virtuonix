# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
_: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default = pkgs.mkShell {
      buildInputs =
        self'.packages.default.buildInputs
        ++ self'.packages.default.nativeBuildInputs;
    };
  };
}
