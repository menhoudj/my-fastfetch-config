#!/bin/bash

set -e

echo "[*] Installing fastfetch..."

# التحقق من مدير الحزم
if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --noconfirm fastfetch
elif command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y fastfetch
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y fastfetch
else
    echo "[!] Package manager not supported. Install fastfetch manually."
    exit 1
fi

echo "[*] Creating ~/.config/fastfetch directory (if not exists)..."
mkdir -p "$HOME/.config/fastfetch"

echo "[*] Copying config.jsonc..."
cp -f config.jsonc "$HOME/.config/fastfetch/"
sudo mv logos "$HOME/.config/fastfetch/"

echo "[*] Installing myfastfetch to /usr/local/bin..."
sudo cp -f myfastfetch /usr/local/bin/myfastfetch
sudo chmod +x /usr/local/bin/myfastfetch

echo "[✓] Installation completed successfully."
