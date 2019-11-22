//
//  Copyright (C) 2017-2018 Abraham Masri @cheesecakeufo
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


using Gtk;
using Gdk;
using Gst;

namespace Playable {
    int screenWidth;
    int screenHeight;

	public class BackgroundWindow : Gtk.Window {

		GtkClutter.Embed embed;

		// Main container
		public Clutter.Actor mainActor { get; private set; }

		Clutter.Actor wallpaperActor = new Clutter.Actor();

		public BackgroundWindow (int monitorIndex, string fileName) {

			title = "Desktop";

			// Get current monitor size
			getMonitorSize(monitorIndex);

            embed = new GtkClutter.Embed() {width_request = screenWidth, height_request = screenHeight};
            mainActor = embed.get_stage();

			// Setup widgets
			set_size_request(screenWidth, screenHeight);
			resizable = false;
			set_type_hint(WindowTypeHint.DESKTOP);
			set_keep_below(true);
			app_paintable = false;
			skip_pager_hint = true;
			skip_taskbar_hint = true;
			accept_focus = false;
			stick ();
			decorated = false;
			add_events (EventMask.ENTER_NOTIFY_MASK | EventMask.POINTER_MOTION_MASK | EventMask.SMOOTH_SCROLL_MASK);
			//Gtk.drag_dest_set (this, Gtk.DestDefaults.MOTION | Gtk.DestDefaults.DROP, targets, Gdk.DragAction.MOVE);

			mainActor.background_color = Clutter.Color.from_string("black");

			wallpaperActor.set_size(screenWidth, screenHeight);
			wallpaperActor.set_pivot_point (0.5f, 0.5f);

            setVideoWallpaper(fileName);

			// Add widgets
			mainActor.add_child(wallpaperActor);

			// add the widgets
			add(embed);
		}

		void getMonitorSize(int monitorIndex) {

			Rectangle rectangle;
			var screen = Gdk.Screen.get_default ();

			screen.get_monitor_geometry (monitorIndex, out rectangle);

			screenHeight = rectangle.height;
			screenWidth = rectangle.width;

			move(rectangle.x, rectangle.y);

		}


        void setVideoWallpaper(string fileName) {

            ClutterGst.Playback videoPlayback = new ClutterGst.Playback ();
            ClutterGst.Content  videoContent = new ClutterGst.Content();
            videoPlayback.set_seek_flags (ClutterGst.SeekFlags.ACCURATE);

            videoContent.player = videoPlayback;

            videoPlayback.notify["progress"].connect(() => {

                if(videoPlayback.progress >= 1.0) {
                    videoPlayback.progress = 0.0;
                    videoPlayback.playing = true;
                }

            });

            wallpaperActor.scale_y = 1.00f;
            wallpaperActor.scale_x = 1.00f;   

            videoPlayback.set_filename(fileName);
            videoPlayback.playing = true;

            wallpaperActor.set_content(videoContent);

        }

        // void setImageWallpaper(string fileName) {
        //     wallpaperActor.scale_y = 1.05f;
        //     wallpaperActor.scale_x = 1.05f;   
        //     
        //     Gtk.Image image = new Gtk.Image.from_file(fileName);
        //     GtkClutter.Actor actor = new GtkClutter.Actor.with_contents(image);
        //     actor.set_size(screenWidth, screenHeight);

        //     wallpaperActor.set_content(null);
        //     wallpaperActor.add_child(actor);
        // }

	}
}
