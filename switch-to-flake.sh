#!/usr/bin/env bash
# Switch System to Dotfiles Flake
# This script switches from /etc/nixos to ~/.dotfiles flake

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "''${BLUE}╔════════════════════════════════════════════════════════════╗''${NC}"
echo -e "''${BLUE}║''${NC}  🔄 Switching to Dotfiles Flake                          ''${BLUE}║''${NC}"
echo -e "''${BLUE}╚════════════════════════════════════════════════════════════╝''${NC}"
echo ""

# Check if dotfiles exist
if [ ! -d ~/.dotfiles ]; then
    echo -e "''${RED}❌ Error: ~/.dotfiles not found!''${NC}"
    exit 1
fi

# Check for available hosts
echo -e "''${BLUE}📋 Available hosts in flake:''${NC}"
cd ~/.dotfiles
hosts=$(nix flake show --json 2>/dev/null | jq -r '.nixosConfigurations | keys[]' 2>/dev/null || ls -1 hosts/ 2>/dev/null | grep -v common)

if [ -z "$hosts" ]; then
    echo "  Found hosts:"
    ls -1 ~/.dotfiles/hosts/ 2>/dev/null | grep -v common | sed 's/^/    - /'
else
    echo "$hosts" | sed 's/^/  - /'
fi
echo ""

# Ask which host to use
echo -e "''${YELLOW}Which host config do you want to use?''${NC}"
echo "  1) personal    (Desktop with Hyprland + KDE)"
echo "  2) work       (Work setup)"
echo "  3) development (Development machine)"
echo ""
read -p "Enter choice [1-3] or type hostname: " choice

case $choice in
    1) HOST="personal" ;;
    2) HOST="work" ;;
    3) HOST="development" ;;
    *) HOST="$choice" ;;
esac

echo ""
echo -e "''${BLUE}🚀 Building with host: $HOST''${NC}"
echo ""

# Test build first (dry run)
echo -e "''${YELLOW}🧪 Testing build (--dry-build)...''${NC}"
if sudo nixos-rebuild dry-build --flake ~/.dotfiles#$HOST; then
    echo -e "''${GREEN}✓ Build test successful''${NC}"
else
    echo -e "''${RED}❌ Build test failed! Check errors above.''${NC}"
    exit 1
fi

echo ""
echo -e "''${YELLOW}⚠ About to switch system to flake configuration''${NC}"
echo "   Current: /etc/nixos/configuration.nix"
echo "   New:     ~/.dotfiles (host: $HOST)"
echo ""
read -p "Continue with switch? [y/N] " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    echo ""
    echo -e "''${BLUE}🔨 Building and activating...''${NC}"
    
    # Backup current config
    sudo cp -r /etc/nixos /etc/nixos.backup.$(date +%Y%m%d-%H%M%S)
    
    # Switch to flake
    sudo nixos-rebuild switch --flake ~/.dotfiles#$HOST
    
    echo ""
    echo -e "''${GREEN}✅ Successfully switched to flake configuration!''${NC}"
    echo ""
    echo -e "''${BLUE}📊 Status:''${NC}"
    echo "  Host: $HOST"
    echo "  Flake: ~/.dotfiles"
    echo "  Home-manager: Integrated as NixOS module"
    echo "  Snapshots: Enabled in boot menu"
    echo ""
    echo -e "''${YELLOW}💡 Quick commands:''${NC}"
    echo "  cd ~/.dotfiles"
    echo "  ./rebuild.sh $HOST switch    # Rebuild with snapshots"
    echo "  sudo bootctl list              # View boot entries"
    echo "  home-manager --version         # Check home-manager"
    echo ""
    echo -e "''${GREEN}🎉 Done! Reboot to see new boot entries with labels.''${NC}"
else
    echo "Cancelled."
    exit 0
fi