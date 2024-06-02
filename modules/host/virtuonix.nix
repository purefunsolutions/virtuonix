# SPDX-FileCopyrightText: 2024 Mika Tammi / Pure Fun Solutions
#
# SPDX-License-Identifier: MIT
#
# Module of Virtuonix systemd service
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.virtuonix;
  defaultUser = "virtuonix";
  defaultGroup = defaultUser;
in {
  options.services.virtuonix = {
    enable = lib.mkEnableOption "Virtuonix";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ../../../pkgs/virtuonix {};
      defaultText = lib.literalExpression "pkgs.callPackage ../../../pkgs/virtuonix {};";
      description = lib.mdDoc "The package to use for the Virtuonix.";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = defaultUser;
      example = defaultUser;
      description = lib.mdDoc ''
        The user for the service. If left as the default value this user will
        automatically be created.
      '';
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = defaultGroup;
      example = defaultGroup;
      description = lib.mdDoc ''
        The group for the service. If left as the default value this group will
        automatically be created.
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    users = {
      users = lib.mkIf (cfg.user == defaultUser) {
        "${defaultUser}" = {
          inherit (cfg) group;
          isSystemUser = true;
        };
      };
      # TODO: Possibly add the user to KVM group
      groups = lib.mkIf (cfg.group == defaultGroup) {
        "${defaultGroup}" = {};
      };
    };
    systemd.services.virtuonix = {
      eanble = true;
      description = "Virtuonix";
      path = [cfg.package];
      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        Type = "simple";
        StandardOutput = "journal";
        StandardError = "journal";
        ExecStart = lib.concatStringsSep " " [
          "${cfg.package}/bin/virtuonix"
        ];
        Restart = "always";
        # TODO: Figure out right set of ambient capabilities
        # TODO: Maybe run inside landlock for additional security
      };
      after = ["tee-supplicant.service"];
      wantedBy = ["multi-user.target"];
    };
  };
}
