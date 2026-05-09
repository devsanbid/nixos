#!/usr/bin/env bash
# NixOS Rebuild with Snapshots — Wrapper for sanbid's dotfiles
# Usage: ./rebuild [personal|work|development] [switch|build|test]

set -e

HOST="''${1:-personal}"
MODE="''${2:-switch}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "''${BLUE}╔════════════════════════════════════════════════════════════╗''${NC}"
echo -e "''${BLUE}║''${NC}  🚀 NixOS Rebuild Script                                  ''${BLUE}║''${NC}"
echo -e "''${BLUE}║''${NC}  Host: ''${YELLOW}$HOST''${NC}                                    ''${BLUE}║''${NC}"
echo -e "''${BLUE}║''${NC}  Mode: ''${YELLOW}$MODE''${NC}                                     ''${BLUE}║''${NC}"
echo -e "''${BLUE}╚════════════════════════════════════════════════════════════╝''${NC}"
echo ""

# Pre-rebuild checks
echo -e "''${BLUE}📋 Pre-flight checks...''${NC}"
if [ ! -d ~/.dotfiles ]; then
    echo -e "''${RED}❌ Error: ~/.dotfiles not found''${NC}"
    exit 1
fi

if [ ! -f ~/.dotfiles/flake.nix ]; then
    echo -e "''${RED}❌ Error: flake.nix not found in ~/.dotfiles''${NC}"
    exit 1
fi

echo -e "''${GREEN}✓ Dotfiles found''${NC}"

# Record start time
START_TIME=$(date +%s)
REBUILD_DATE=$(date "+%Y-%m-%d %H:%M:%S")
BUILD_LABEL="auto-$HOST-$(date +%Y%m%d-%H%M%S)"

echo ""
echo -e "''${BLUE}📦 Building NixOS configuration...''${NC}"
echo "   Flake: ~/.dotfiles#nixosConfigurations.$HOST"
echo "   Build Label: $BUILD_LABEL"
echo ""

# Build with labels for boot menu
export NIXOS_LABEL="$BUILD_LABEL"

# Perform rebuild
(cd ~/.dotfiles && sudo nixos-rebuild $MODE --flake .#$HOST "''${@:3}")

REBUILD_STATUS=$?
END_TIME=$(date +%s)
BUILD_DURATION=$((END_TIME - START_TIME))

echo ""
echo -e "''${BLUE}════════════════════════════════════════════════════════════''${NC}"

if [ $REBUILD_STATUS -eq 0 ]; then
    echo -e "''${GREEN}✅ Rebuild Successful!''${NC}"
    echo ""
    echo -e "  📅 Date:     $REBUILD_DATE"
    echo -e "  ⏱️  Duration:  ''${GREEN}''${BUILD_DURATION}s''${NC}"
    echo -e "  🏷️  Label:    $BUILD_LABEL"
    echo -e "  🖥️  Host:     $HOST"
    echo ""
    echo -e "  ''${YELLOW}Home-Manager Status:''${NC}"
    home-manager --version &>/dev/null && echo -e "    ✓ Home-manager active" || echo -e "    ⚠ Home-manager check failed"
    echo ""
    echo -e "''${BLUE}════════════════════════════════════════════════════════════''${NC}"
    echo ""
    echo -e "''${GREEN}🎯 Boot Snapshots:''${NC}"
    echo "  Next boot will show: $BUILD_LABEL"
    echo "  Run 'sudo bootctl list' to see all entries"
    echo ""
    echo -e "''${YELLOW}💡 Tip: Reboot to activate new boot entry with snapshot label''${NC}"
    
    # Create local build info
    cat > ~/.dotfiles/last-build-info.json <<EOF
{
  "host": "$HOST",
  "date": "$REBUILD_DATE",
  "label": "$BUILD_LABEL",
  "duration": $BUILD_DURATION,
  "status": "success"
}
EOF

else
    echo -e "''${RED}❌ Rebuild Failed!''${NC}"
    echo ""
    echo -e "  📅 Date:     $REBUILD_DATE"
    echo -e "  ⏱️  Duration: ''${RED}''${BUILD_DURATION}s''${NC}"
    echo ""
    echo -e "''${YELLOW}Check the output above for errors''${NC}"
    exit 1
fi