# Cleaning Up Your Debian Audio Install
Bart Massey 2021-01

If you're reading this I'm guessing something bad has
happened with your PipeWire or PulseAudio install on recent
Debian. Maybe try the following?

*Note: This suggested process is only very lightly tested by
me and could damage your Debian installation. Many of the
commands here need to be run as root. Use this at your own
risk with good judgement and common sense.*

* Start with

        apt-get -s purge pipewire pulseaudio \
        libpipewire-0.3-modules libwireplumber-0.4-0 pipewire-bin \
        > purge-list.txt

  (the `-s` is very important here). This will get you a
  list of packages that you might want to put back when
  done.

* Run the above command again without the `-s` and the
  redirection. Do not autoremove: you'll just be putting
  stuff back anyhow.

* `killall pipewire` just in case.

* Move aside (or just remove) `$HOME/.config/pulse` and
  `$HOME/.config/pipewire-media-session` and anything else
  that looks suspicious (e.g. `pavucontrol.ini`)

* Remove `/etc/alsa/conf.d/*{pipewire,pulseaudio}*` and
  `/etc/ld.so.conf.d/*pipewire*`. Run `ldconfig`.

* Remove any likely leftovers from `/usr/lib/systemd/user`
  and subdirectories, and from `$HOME/.config/systemd/user`.

* `apt install pulseaudio`

* Reinstall any dependencies you lost with the earlier purge
  and want back. Then you can `apt autoremove` the rest.

* Run `sh pipewire-mode.sh enable-pulseaudio` (as yourself)
  to undo any `systemd` config script state damage.

* You should be in good shape. Try rebooting the machine to
  make sure. If that doesn't work, something is horribly
  borked and I don't know how to help you.

* If desired, use the script in this repo to try to
  re-enable pipewire.
