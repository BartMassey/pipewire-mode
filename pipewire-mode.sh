#!/bin/sh
# Manage Pipewire (vs Pulseaudio) on a Debian box.
# Bart Massey 2021-12

SYSTEMCTL="systemctl --user --now"
EXAMPLES=/usr/share/doc/pipewire/examples

case "$1" in
    install-pipewire)
        sudo apt -t unstable install \
          pipewire wireplumber \
          pipewire-media-session- pulseaudio-module-bluetooth- \
          pipewire-audio-client-libraries pipewire-pulse \
          libspa-0.2-jack libspa-0.2-bluetooth \
          qjackctl
        if [ $? -ne 0 ]
        then
            echo "cancelled: aborting" >&2
            exit 1
        fi
        cat <<EOF |
        cp $EXAMPLES/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/
        cp $EXAMPLES/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
        ldconfig
EOF
        sudo sh
        systemctl --user daemon-reload
        sh "$0" enable-pipewire
        ;;
    just-enable-pipewire)
        $SYSTEMCTL enable pipewire.service pipewire.socket
        $SYSTEMCTL enable pipewire-pulse.service pipewire-pulse.socket
        $SYSTEMCTL enable wireplumber.service
        ;;
    just-enable-pulseaudio)
        $SYSTEMCTL unmask pulseaudio
        $SYSTEMCTL enable pulseaudio.service pulseaudio.socket
        ;;
    disable-pipewire)
        $SYSTEMCTL disable wireplumber.service
        $SYSTEMCTL disable pipewire-pulse.socket pipewire-pulse.service
        $SYSTEMCTL disable pipewire.socket pipewire.service
        ;;
    disable-pulseaudio)
        $SYSTEMCTL disable pulseaudio.socket pulseaudio.service
        $SYSTEMCTL mask pulseaudio
        ;;
    enable-pipewire)
        sh "$0" disable-pulseaudio
        sh "$0" just-enable-pipewire
        ;;
    enable-pulseaudio)
        sh "$0" disable-pipewire
        sh "$0" just-enable-pulseaudio
        ;;
    restart-pipewire)
        sh "$0" disable-pipewire
        sh "$0" just-enable-pipewire
        ;;
    *)
        echo "$0: unknown command $1" >&2
        exit 1
        ;;
esac
