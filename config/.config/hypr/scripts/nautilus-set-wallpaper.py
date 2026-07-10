from gi.repository import Nautilus, GObject
import subprocess
import os


class SetWallpaperExtension(GObject.GObject, Nautilus.MenuProvider):
    def get_file_items(self, *args):
        files = args[-1]
        if len(files) != 1:
            return []
        file = files[0]
        if not file.get_mime_type().startswith("image/"):
            return []
        item = Nautilus.MenuItem(
            name="SetWallpaper::set_wallpaper",
            label="Set this image as background",
            tip="Use this image as the Hyprland wallpaper",
        )
        item.connect("activate", self._set_wallpaper, file)
        return [item]

    def _set_wallpaper(self, menu, file):
        path = file.get_location().get_path()
        script = os.path.expanduser("~/.config/hypr/scripts/set-wallpaper.sh")
        subprocess.Popen([script, path])
