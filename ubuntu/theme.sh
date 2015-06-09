
	
Remove ugly fat bazel from gnome-terminal with multiple-tabs

    Edit /usr/share/themes/Ambiance/gtk-3.0/apps/gnome-terminal.css and add:

        TerminalWindow .notebook {
            padding: 0;
            border-width: 0;
        }

    and close all the terminal windows and open it will be ok


if you don't already have it, create or open a gtk.css file in this path

~/.config/gtk-3.0/gtk.css

Paste the following code, close all terminals and start one new.

@define-color bg-grey #222;
@define-color active-grey #333;
@define-color border-grey #555;


TerminalWindow .notebook {
  border: 0;
  padding: 0;
  color: #eee;
  background-color: shade(@active-grey, 1);
}

TerminalWindow .notebook tab:active {
  border: 1px solid @border-grey;
  background-color: shade(@active-grey, 1);
}

TerminalWindow .notebook tab {
  background-color: shade(@bg-grey, 1);
}
    

