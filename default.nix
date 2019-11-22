{ pkgs ? import <nixpkgs> {} }: with pkgs;
stdenv.mkDerivation {
  name = "animated-wallpaper";
  src = lib.cleanSource ./.;
  nativeBuildInputs = [
    wrapGAppsHook
  ];
  buildInputs = with gnome3; with gst_all_1; [
    cmake vala pkgconfig
    gtk3-x11 clutter-gtk
    clutter clutter-gst
    gst-libav gst-vaapi
    gst-plugins-good
  ];
}
