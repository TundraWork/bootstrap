# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# go
export GOPATH=~/go
if [ -d "$GOPATH/bin" ] ; then
    PATH="$PATH:$GOPATH/bin"
fi

# set GUI scaling
export QT_ENABLE_HIGHDPI_SCALING=1
#export QT_SCALE_FACTOR=2
export GDK_SCALE=2
export GDK_BACKEND=wayland

# Use WSLg as X server (XWayland)
export DISPLAY=:0
# Use X410 as X server (VSOCK via modified /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0)
#export DISPLAY=vsock/:0
# Use X410 as X server (VSOCK)
#socat -b65536 UNIX-LISTEN:/tmp/.X11-unix/X1,fork,mode=777 VSOCK-CONNECT:2:6000 &
#export DISPLAY=:1.0
# Use X410 as X server (TCP)
#export DISPLAY=$(cat /run/host-ip):0.0

# SSH agent
# NOTE: The ssh-agent is managed by systemd user unit, no need to launch it manually
# always export SSH_AUTH_SOCK for each session
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}ssh-agent.socket"
# ssh-agent bootstrap only needs to be done once for a system boot
if [[ ! -f /run/user/1000/.ssh-agent-ready ]]; then
    echo "Waiting for systemd to be ready..."
    while ! systemctl is-active --quiet multi-user.target > /dev/null 2>&1; do
        sleep 1
    done
    echo "Adding SSH keys..."
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/id_ed25519
    touch /run/user/1000/.ssh-agent-ready
fi
