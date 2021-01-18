
# What is this?

I want to have animated wallpaper on Gnome3, but there is no official support and I didn't find a good solution. [Komorebi](https://github.com/cheesecakeufo/komorebi) can create a dynamic desktop using a video but its functionality is bloated to me, so I recreate some of its core function into this small utility.

# Usage

```shell
animated-wallpaper [FILE]
```

Play and loop the video `FILE` on your desktop.

# Note

- Will increase your CPU usage and lower your battery life

# Build && Install

## For Nix Users

```shell
nix-env -i -f https://github.com/Ninlives/animated-wallpaper/archive/master.tar.gz
```

## Others

These instructions should work but I didn't test it, tell me if you encounter any problems.

### Requirements

- cmake
- vala
- pkgconfig
- gtk3
- clutter 
- clutter-gtk
- clutter-gst
- gst-libav

### Instructions

```shell
git clone https://github.com/Ninlives/animated-wallpaper
cd animated-wallpaper
cmake . && make && make install
```
