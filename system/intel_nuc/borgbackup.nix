{ config, pkgs, ... }:
{
  # https://christine.website/blog/borg-backup-2021-01-09
  services.borgbackup.jobs."borgbase" = {
    compression = "auto,lzma";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borgbackup_passphrase";
    };
    environment.BORG_RSH = "ssh -i /root/borgbackup_ssh";
    exclude = [
    ];
    paths = [
      "/srv"
    ];
    prune.keep = ''
      {
        within = "1d";
        daily = 7;
        weekly = 4;
        monthly = 6;
      }
    '';
    repo = "<repourl>:repo";
    startAt = "daily";
  };
}
