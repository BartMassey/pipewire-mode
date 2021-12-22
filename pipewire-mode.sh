#!/bin/sh

SYSTEMCTL="systemctl --user --now"

$SYSTEMCTL disable pipewire-media-session.service
$SYSTEMCTL disable pipewire-pulse.service
$SYSTEMCTL disable pipewire.service pipewire.socket
$SYSTEMCTL disable pulseaudio.service pulseaudio.socket
systemctl --user mask pulseaudio

sudo apt -t unstable install \
  pipewire wireplumber \
  pipewire-media-session- pulseaudio-module-bluetooth- \
  pipewire-audio-client-libraries pipewire-pulse \
  libspa-0.2-jack libspa-0.2-bluetooth \
  qjackctl

EXAMPLES=/usr/share/doc/pipewire/examples
sudo cp $EXAMPLES/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/
sudo cp $EXAMPLES/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
sudo ldconfig

systemctl --user daemon-reload

$SYSTEMCTL enable pipewire.service pipewire.socket
$SYSTEMCTL enable pipewire-pulse.service
$SYSTEMCTL enable wireplumber.service
