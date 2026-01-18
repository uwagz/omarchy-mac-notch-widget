# Mac Notch Widget for Omarchy

A Waybar widget that transforms your MacBook's notch into a useful control panel. Hover over the notch area to reveal:

- **Now Playing** - Current track from Spotify, browser, or any MPRIS player
- **System Stats** - Weather, battery, CPU, memory
- **Quick Controls** - Network, Bluetooth device, brightness, volume

![Notch Widget Demo](demo.gif)

## Requirements

- [Omarchy](https://omarchy.org/) Linux on Apple Silicon Mac (M1/M2/M3)
- Waybar
- playerctl (for media controls)
- brightnessctl (for brightness control)
- pamixer (for volume control)

## Installation

```bash
git clone https://github.com/yourusername/omarchy-mac-notch-widget.git
cd omarchy-mac-notch-widget
chmod +x install.sh
./install.sh
```

Then either log out and back in, or start the widget manually:

```bash
waybar -c ~/.config/waybar/notch/config.jsonc -s ~/.config/waybar/notch/style.css &
```

## Uninstallation

```bash
./uninstall.sh
```

## Files

| File | Description |
|------|-------------|
| `config.jsonc` | Waybar module configuration |
| `style.css` | Widget styling (black background, card-based UI) |
| `restart.sh` | Helper script to restart both main and notch waybars |
| `install.sh` | Installation script |
| `uninstall.sh` | Uninstallation script |

## Configuration

### Adjusting Position

If the widget doesn't align with your notch, edit `config.jsonc`:

```jsonc
{
  "margin-top": -50,  // Adjust this value
  "width": 320,       // Widget width
  "height": 50        // Hover target height
}
```

### Customizing Weather Location

By default, weather is auto-detected by IP. To set a specific location, edit the weather exec in `config.jsonc`:

```jsonc
"custom/weather": {
  "exec": "curl -s 'wttr.in/London?format=%c+%t' | tr -d '+'",
  ...
}
```

### Changing Modules

Edit `config.jsonc` to add/remove modules from the `group/stats` or `group/controls` arrays.

## How It Works

The widget is a separate Waybar instance that:

1. Sits as an invisible overlay at the top-center of the screen
2. Uses `opacity: 0` by default (completely hidden)
3. On hover, expands downward and fades in (`opacity: 1`)
4. Uses pure black background to seamlessly extend from the notch

## Credits

Built for [Omarchy](https://omarchy.org/) - A beautiful Arch Linux distribution with Hyprland.

## License

MIT
