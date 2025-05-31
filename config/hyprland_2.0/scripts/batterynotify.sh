
#!/usr/bin/env bash

get_battery_percentage() {
    # Try different methods to get battery info
    if [ -f /sys/class/power_supply/BAT0/capacity ]; then
        cat /sys/class/power_supply/BAT0/capacity
    elif [ -f /sys/class/power_supply/BAT1/capacity ]; then
        cat /sys/class/power_supply/BAT1/capacity
    elif command -v acpi >/dev/null 2>&1; then
        acpi -b | grep -P -o '[0-9]+(?=%)'
    elif command -v upower >/dev/null 2>&1; then
        upower -i $(upower -e | grep 'BAT') | grep -E "percentage" | awk '{print $2}' | sed 's/%//'
    else
        echo "Error: Unable to detect battery percentage" >&2
        exit 1
    fi
}

# Function to check if AC adapter is connected
is_charging() {
    if [ -f /sys/class/power_supply/ADP1/online ]; then
        [ "$(cat /sys/class/power_supply/ADP1/online)" = "1" ]
    elif [ -f /sys/class/power_supply/AC/online ]; then
        [ "$(cat /sys/class/power_supply/AC/online)" = "1" ]
    elif [ -f /sys/class/power_supply/ACAD/online ]; then
        [ "$(cat /sys/class/power_supply/ACAD/online)" = "1" ]
    elif command -v acpi >/dev/null 2>&1; then
        acpi -a | grep -q "on-line"
    else
        false
    fi
}

# Main logic
main() {
    local battery_level
    local threshold=20
    
    battery_level=$(get_battery_percentage)
    
    # Check if we got a valid number
    if ! [[ "$battery_level" =~ ^[0-9]+$ ]]; then
        echo "Error: Could not determine battery percentage" >&2
        exit 1
    fi
    
    echo "Current battery level: ${battery_level}%"
    
    # Send notification if battery is low and not charging
    if [ "$battery_level" -le "$threshold" ]; then
        if is_charging; then
            echo "Battery low but charging, no notification sent"
        else
            notify-send \
                --urgency=critical \
                --icon=battery-caution \
                "Battery Low!" \
                "Battery level is ${battery_level}%. Please connect charger."
            echo "Low battery notification sent (${battery_level}%)"
        fi
    else
        echo "Battery level OK (${battery_level}%)"
    fi
}

# Run the main function
main "$@"
