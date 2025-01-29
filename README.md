For reference only. Do not directly copy and paste these commands. Review and modify them as necessary before running.

```bash
pacman-key --init
pacman-key --populate
pacman -Syu

pacman -S base base-devel sudo curl wget vim man-db man-pages git openssh zsh

echo "wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel

useradd -m -s /usr/bin/zsh tundra
passwd -d tundra
usermod -aG wheel tundra
```

```bash
su tundra
cd ~
```

```bash
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S zsh-antidote
```

```bash
# After creating `.config/systemd/user/ssh-agent.service`
systemctl --user enable --now ssh-agent.service
```

```bash
# After creating `/etc/systemd/system/fix-wslg.service`
sudo systemctl enable --now fix-wslg.service
```
