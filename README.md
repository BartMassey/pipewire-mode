# pipewire-mode: Control PipeWire (vs PulseAudio) on Debian
Bart Massey 2022-01

This shell script's primary function is to cleanly install
and set up current Debian `unstable`
[PipeWire](https://wiki.debian.org/PipeWire) (tested with
0.3.42) and associated utilities on a box running Debian
Linux Bullseye. If the box is also running
[PulseAudio](https://wiki.debian.org/PulseAudio) that will
be disabled (but not uninstalled in the process).

If you are trying to clean up a broken audio install, and
PulseAudio and/or PipeWire are installed, and you are very
brave or very foolish, you can try the
[cleanup instructions](CLEANUP.md) here to get things going
again.

## Run

    sh pipewire-mode.sh install-pipewire

A variety of commands are available:

* `install-pipewire`: Installs and enables PipeWire,
  disabling PulseAudio if present.

* `enable-pipewire`: Enables PipeWire, disabling PulseAudio
  if present.

* `enable-pulseaudio`: Enables PulseAudio, disabling Pipewire
  if present.

* `restart-pipewire`: Stops PipeWire and restarts
  it. (Assumes PipeWire was running before.)

There are also some other internal commands.

## License

This work is made available under the "MIT License". Please
see the file `LICENSE` in this distribution for license
terms.
