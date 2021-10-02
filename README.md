# nixos
personal nixos configurations as flake

## installation

### filesystem

```sh
export ROOT_DISK=/dev/sda

# create partitions
sudo parted -a opt --script "${ROOT_DISK}" \
    mklabel gpt \
    mkpart primary fat32 0% 512MiB \
    set 1 esp on \
    name 1 boot \
    mkpart primary 512MiB 100% \
    set 2 lvm on \
    name 2 root

fdisk ${ROOT_DISK} -l

# setup virtuals
sudo vgcreate vg ${ROOT_DISK}2

sudo lvcreate -L 8G -n swap vg
sudo lvcreate -l '100%FREE' -n root vg

lvdisplay

# format partitions
sudo mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/boot
sudo mkfs.ext4 -L root /dev/vg/root
sudo mkswap -L swap /dev/vg/swap

swapon -s

# mount for install
sudo mount /dev/disk/by-label/root /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo swapon /dev/vg/swap

# install
nix-shell -p git nixFlakes

sudo git clone https://github.com/aserowy/nixos.git /mnt/etc/nixos
sudo nixos-install --root /mnt --flake /mnt/etc/nixos#workstation
sudo rm -rf /mnt/etc/nixos

reboot
```
