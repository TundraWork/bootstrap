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

cat << EOF >> ~/.zshrc

# source antidote
source '/usr/share/zsh-antidote/antidote.zsh'
# initialize plugins statically with ~/.zsh_plugins.txt
antidote load
EOF

cat << EOF > ~/.zsh_plugins.txt
getantidote/use-omz
ohmyzsh/ohmyzsh path:lib
ohmyzsh/ohmyzsh path:plugins/colored-man-pages
ohmyzsh/ohmyzsh path:plugins/magic-enter
ohmyzsh/ohmyzsh path:themes/bira.zsh-theme

zsh-users/zsh-completions kind:fpath path:src
zsh-users/zsh-autosuggestions
zsh-users/zsh-syntax-highlighting
zsh-users/zsh-history-substring-search
EOF
```

```bash
# After creating `.config/systemd/user/ssh-agent.service`
systemctl --user enable ssh-agent.service
```

```bash
# After creating `/etc/systemd/system/wslg.service`
sudo systemctl enable wslg.service
```
