# ctrl-dir-scroll package

This project is an [Atom](http://atom.io/) package.

It's meant to reproduce the Line Up/Down functionality of [Sublime](http://www.sublimetext.com/) and SCI_LINESCROLLUP/DOWN functionality from [Notepad++](http://notepad-plus-plus.org/)

The desired behaviour is to have `Ctrl-Up` (`Ctrl-Alt-Up` on Mac) scroll the page a single line up, leaving the cursor in place.
The same should happen for `Ctrl-Down` (`Ctrl-Alt-Up` on Mac) but in the opposite direction.

You can also use `Ctrl-Shift-Up/Down` (`Ctrl-Alt-Shift-Up/Down` on Mac) to move 10 lines at a time (amount of lines configurable).

When the cursor reaches the end of the page, it should scroll a single line as well to prevent it moving off the page (this can be disabled in settings).

Also have a look at [line-jumper](https://atom.io/packages/line-jumper) which allows you to move the cursor 10 lines at a time.

Atom version 1.0 compliant thanks to [harai](https://github.com/harai)
Multiple line jumping thanks to [kankaristo](https://github.com/kankaristo)
