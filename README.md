# systemd timer for battery notifications

A simple systemd timer to notify the user
when the battery crosses a certain threshold.
The default upper bound is 80% and
the default lower bound is 40%.

### Installation

1. Clone the repo.
```
git clone https://github.com/rhz/sd-battery-notification.git
```
2. Create a symlink to the timer and service unit files.
```
cd ~/.config/systemd/user/
ln -s /path/to/local/repo/sd_battery_notification{.timer,.service} .
```
3. Put a symlink to the bash script in your `$PATH` or copy it.
I use `~/.local/bin/` and added it my `PATH` environment variable,
but you can choose any folder in your `PATH` you like.
```
cd ~/.local/bin/
ln -s /path/to/local/repo/sd_battery_notification.sh .
```
4. Start and/or enable the timer.
```
systemctl --user start sd_battery_notification.timer
```
5. List the active timers. It should appear there after starting it
(or enabling it with the `--now` option).
```
systemctl --user list-timers
```
