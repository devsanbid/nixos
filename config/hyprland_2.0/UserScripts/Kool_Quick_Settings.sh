#!/run/current-system/sw/bin/bash


# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Rofi menu for KooL Hyprland Quick Settings (SUPER SHIFT E)

# Define preferred text editor and terminal
edit=${EDITOR:-nano}
tty=kitty

# variables
configs="$HOME/.dotfiles/config/hyprland_2.0/configs"
bookmarks="$HOME/.dotfiles/bookmarks"
UserConfigs="$HOME/.dotfiles/config/hyprland_2.0/UserConfigs"
rofi_theme="$HOME/.dotfiles/config/rofi/config-edit.rasi"
msg=' ⁉️ Choose what to do ⁉️'
iDIR="$HOME/.dotfiles/config/swaync/images"
scriptsDir="$HOME/.dotfiles/config/hyprland_2.0/scripts"
UserScripts="$HOME/.dotfiles/config/hyprland_2.0/UserScripts"

# Function to display the menu options without numbers
menu() {
    cat <<EOF
view/edit ENV variables
view/edit Window Rules
view/edit User Keybinds
view/edit User Settings
view/edit Startup Apps
view/edit Decorations
view/edit Animations
view/edit Laptop Keybinds
view/edit Default Keybinds
Configure Monitors (nwg-displays)
Configure Workspace Rules (nwg-displays)
Choose Hyprland Animations
Choose Monitor Profiles
Choose Rofi Themes
Search for Keybinds
Bookmarks for browser
EOF
}

# Main function to handle menu selection
main() {
    choice=$(menu | rofi -i -dmenu -config $rofi_theme -mesg "$msg")

    # Map choices to corresponding files
    case "$choice" in
        "view/edit ENV variables") file="$UserConfigs/ENVariables.conf" ;;
        "view/edit Window Rules") file="$UserConfigs/WindowRules.conf" ;;
        "view/edit User Keybinds") file="$UserConfigs/UserKeybinds.conf" ;;
        "view/edit User Settings") file="$UserConfigs/UserSettings.conf" ;;
        "view/edit Startup Apps") file="$UserConfigs/Startup_Apps.conf" ;;
        "view/edit Decorations") file="$UserConfigs/UserDecorations.conf" ;;
        "view/edit Animations") file="$UserConfigs/UserAnimations.conf" ;;
        "view/edit Bookmarks Personal") file="$bookmarks/personal.conf" ;;
        "view/edit Bookmarks Work") file="$bookmarks/work.conf" ;;
        "view/edit Laptop Keybinds") file="$UserConfigs/Laptops.conf" ;;
        "view/edit Default Keybinds") file="$configs/Keybinds.conf" ;;
        "Configure Monitors (nwg-displays)")
            if ! command -v nwg-displays &>/dev/null; then
                notify-send -i "$iDIR/ja.png" "E-R-R-O-R" "Install nwg-displays first"
                exit 1
            fi
            nwg-displays ;;
        "Configure Workspace Rules (nwg-displays)")
            if ! command -v nwg-displays &>/dev/null; then
                notify-send -i "$iDIR/ja.png" "E-R-R-O-R" "Install nwg-displays first"
                exit 1
            fi
            nwg-displays ;;
        "Choose Hyprland Animations") $scriptsDir/Animations.sh ;;
        "Choose Monitor Profiles") $scriptsDir/MonitorProfiles.sh ;;
        "Choose Rofi Themes") $scriptsDir/RofiThemeSelector.sh ;;
        "Search for Keybinds") $scriptsDir/KeyBinds.sh ;;
        *) return ;;  # Do nothing for invalid choices
    esac

    # Open the selected file in the terminal with the text editor
    if [ -n "$file" ]; then
        $tty -e $edit "$file"
    fi
}

# Check if rofi is already running
if pidof rofi > /dev/null; then
  pkill rofi
fi

main
