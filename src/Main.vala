//
//  Copyright (C) 2016-2017 Abraham Masri
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

using Playable;
namespace Wallpaper {

    BackgroundWindow[] backgroundWindows;

    public static void main (string [] args) {

        if(args[1] == "--help" || args[1] == "-h" || args.length != 2) {
            print("Usage:\n\tanimated-wallpaper [FILE]");
            return;
        }

        GtkClutter.init (ref args);
        Gtk.init (ref args);
        Gst.init (ref args);

        var screen = Gdk.Screen.get_default ();
        int monitorCount = screen.get_n_monitors();

        backgroundWindows = new BackgroundWindow[monitorCount];
        string fileName = args[1];
        for (int i = 0; i < monitorCount; ++i)
            backgroundWindows[i] = new BackgroundWindow(i, fileName);

        var mainSettings = Gtk.Settings.get_default ();
        mainSettings.set("gtk-xft-antialias", 1, null);
        mainSettings.set("gtk-xft-rgba" , "none", null);
        mainSettings.set("gtk-xft-hintstyle" , "slight", null);

        for (int i = 0; i < monitorCount; ++i)
            backgroundWindows[i].show_all();

        Clutter.main();
    }
}
