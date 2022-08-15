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
        string displayName = "";
	bool isDisplay = false;
        Gdk.Screen screen;
        Gdk.Display display;
        if(args[1] == "--help" || args[1] == "-h" || (args.length != 2 && args.length != 4)) {
            print("Usage:\n\tanimated-wallpaper [FILE] \n\tor: animated-wallpaper [FILE] -s [displayName]\n\tor: animated-wallpaper [FILE] --screen [displayName]\n");
            return;
        }
        if(args.length == 4 && (args[2] == "-s" || args[2] == "--screen")) {
            displayName = args[3];
            isDisplay = true;
            print("Trying to use display: " + displayName + "\n");
        }
        GtkClutter.init (ref args);
        Gtk.init (ref args);
        Gst.init (ref args);

        int monitorCount;
        if(isDisplay) {
            display = Gdk.Display.open(displayName);
            if(display.get_name() != displayName) {
                print("Error: Can't open display " + displayName + "\n");
                return;
            }
            monitorCount = display.get_n_monitors();
        }
        else {
            screen = Gdk.Screen.get_default();
            monitorCount = screen.get_n_monitors();
        }

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
