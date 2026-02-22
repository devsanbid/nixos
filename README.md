# 🏠 Sanbid's NixOS Configuration

Modern, modular NixOS configuration with **3 host profiles** and **3 desktop environments**.

## 📁 Structure

```
nixos-config/
├── flake.nix                      # Entry point — defines 3 hosts
├── hosts/
│   ├── common/                    # Shared hardware + base config
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── work/                      # Full DMS + Waybar + OBS
│   │   ├── default.nix
│   │   └── home.nix
│   ├── development/               # KDE-focused, no DMS, no waybar
│   │   ├── default.nix
│   │   └── home.nix
│   └── personal/                  # Full setup + gaming + DMS
│       ├── default.nix
│       └── home.nix
├── modules/
│   ├── nixos/                     # System-level NixOS modules
│   │   ├── core/                  # boot, nix, locale
│   │   ├── desktop/               # hyprland, kde, niri (toggleable)
│   │   ├── hardware/              # nvidia, pipewire, dbus
│   │   ├── network/               # NetworkManager, DNS
│   │   ├── security/              # ssh, firewall, automount
│   │   ├── services/              # gnome-keyring, ollama
│   │   ├── users/                 # user accounts
│   │   ├── programs/              # shells, nix-ld, nh
│   │   ├── packages/              # all system packages (by category)
│   │   ├── environment/           # env vars, XDG, CUDA
│   │   ├── fonts/                 # Nerd Fonts
│   │   ├── apps/                  # docker, flatpak, distrobox
│   │   └── gaming.nix             # optional gaming module
│   └── home/                      # Home-Manager modules
│       ├── desktop/               # hyprland, niri (HM-level)
│       ├── shell/                 # fish, zsh, starship, tmux
│       ├── terminal/              # kitty, alacritty
│       ├── apps/                  # waybar, rofi, fuzzel, dunst, etc.
│       ├── dev/                   # git, neovim, scripts
│       └── theming/               # wallust, themes, hyprland-rice
└── config/                        # Raw config files (symlinked)
```

## 🖥️ Desktop Environments

| Desktop  | Type       | Status      | Notes                              |
|----------|-----------|-------------|-------------------------------------|
| Hyprland | Compositor | **Primary** | Full rice, animations, vim keys     |
| KDE 6    | DE        | Fallback    | Plasma 6 + SDDM, development DE    |
| Niri     | Compositor | Experimental | Scrollable tiling, Hyprland keybinds |

## 🏗️ Host Profiles

### `work` — Full productivity setup
- ✅ Hyprland + KDE + Niri
- ✅ DankMaterialShell + DankSearch
- ✅ Waybar, OBS, wf-recorder
- ✅ All dev tools

### `development` — Lean dev environment
- ✅ Hyprland + KDE (primary) + Niri
- ❌ No DMS (uses KDE panels)
- ❌ No Waybar (KDE panel)
- ✅ All dev tools

### `personal` — Everything + gaming
- ✅ Hyprland + KDE + Niri
- ✅ DankMaterialShell + DankSearch
- ✅ Waybar, OBS, wf-recorder
- ✅ Gaming (gamemode, heroic, lutris)

## 🚀 Usage

### Build & Switch
```bash
# Build specific host
nh os switch --hostname work
nh os switch --hostname development
nh os switch --hostname personal

# Or with nixos-rebuild
sudo nixos-rebuild switch --flake .#work
sudo nixos-rebuild switch --flake .#development
sudo nixos-rebuild switch --flake .#personal
```

### Update
```bash
nix flake update
```

### Toggle Features (per-host)
In `hosts/<name>/default.nix`:
```nix
modules.desktop = {
  hyprland.enable = true;   # Toggle Hyprland
  kde.enable = true;        # Toggle KDE
  niri.enable = false;      # Toggle Niri
};
modules.gaming.enable = true;  # Toggle gaming
```

In `hosts/<name>/home.nix`:
```nix
modules.home.apps = {
  waybar.enable = true;     # Toggle waybar
  rofi.enable = true;       # Toggle rofi
  dunst.enable = false;     # Toggle dunst
};
modules.home.shell = {
  fish.enable = true;       # Toggle fish
  zsh.enable = false;       # Toggle zsh
};
```

## 🔑 Key Bindings (consistent across Hyprland & Niri)

| Key              | Action                |
|------------------|-----------------------|
| `Super + Q`      | Terminal (Kitty)      |
| `Super + C`      | Kill window           |
| `Super + R`      | Fuzzel launcher       |
| `Super + E`      | File manager (Thunar) |
| `Super + B`      | Firefox               |
| `Super + F`      | Fullscreen            |
| `Super + V`      | Toggle floating       |
| `Super + H/J/K/L`| Vim-style focus      |
| `Super + 1-0`    | Workspace 1-10       |
| `Super + Shift + 1-0` | Move to workspace |
| `Super + Backspace` | Wlogout (power menu) |
| `Print`          | Screenshot            |

## 🎨 Theming

- **Color scheme**: Catppuccin Mocha
- **Icons**: Papirus-Dark, Tela-circle-dracula
- **Font**: JetBrainsMono Nerd Font, CaskaydiaCove Nerd Font
- **Wallpaper**: Wallust-generated colors from wallpapers
- **GTK**: Adwaita Dark via nwg-look
- **Qt**: qt5ct/qt6ct

## 📦 Hardware

- **Machine**: Lenovo Legion (Intel + NVIDIA)
- **GPU**: NVIDIA PRIME Offload (Intel iGPU + NVIDIA dGPU)
- **Boot**: Secure Boot via Lanzaboote
- **Kernel**: XanMod Stable (BBR3, BORE scheduler)
- **Audio**: PipeWire (ALSA + PulseAudio + JACK)
