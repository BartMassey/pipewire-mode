#!/bin/sh
# Manage Pipewire (vs Pulseaudio) on a Debian box.
# Bart Massey 2021-12

SYSTEMCTL="systemctl --user --now"
EXAMPLES=/usr/share/doc/pipewire/examples

case "$1" in
    install_pipewire)
        cat <<EOF |
        apt -t unstable install \
          pipewire wireplumber \
          pipewire-media-session- pulseaudio-module-bluetooth- \
          pipewire-audio-client-libraries pipewire-pulse \
          libspa-0.2-jack libspa-0.2-bluetooth \
          qjackctl
        systemctl --user daemon-reload
        cp $EXAMPLES/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/
        cp $EXAMPLES/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
        ldconfig
EOF
        sudo sh
        sh "$0" enable-pipewire
        ;;
    enable-pipewire)
        sh "$0" disable-pulseaudio
        $SYSTEMCTL enable pipewire.service pipewire.socket
        $SYSTEMCTL enable pipewire-pulse.service
        $SYSTEMCTL enable wireplumber.service
        ;;
    enable-pulseaudio)
        sh "$0" disable-pipewire
        $SYSTEMCTL unmask pulseaudio
        $SYSTEMCTL enable pulseaudio.service pulseaudio.socket
        ;;
    disable-pipewire)
        $SYSTEMCTL disable pipewire-media-session.service
        $SYSTEMCTL disable pipewire-pulse.service
        $SYSTEMCTL disable pipewire.service pipewire.socket
        ;;
    disable-pulseaudio)
        $SYSTEMCTL disable pulseaudio.service pulseaudio.socket
        $SYSTEMCTL mask pulseaudio
        ;;
esac