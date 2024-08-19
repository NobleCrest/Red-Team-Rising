#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Update and upgrade the system
apt-get update && apt-get upgrade -y

# Install Python3 and pip
apt-get install -y python3 python3-pip

# Download and run pimpmykali for additional tools like impacket, seclists, etc.
curl -sL https://raw.githubusercontent.com/Dewalt-arch/pimpmykali/master/pimpmykali.sh | bash

# Install search-that-hash via pipx
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install search-that-hash

# Install web tools
apt-get install -y feroxbuster sshuttle chisel gobuster nikto

# Install compiler tools
apt-get install -y gcc-multilib mingw-w64
pipx install crackmapexec

# Download Firefox extensions: FoxyProxy, User-Agent Switcher, Wappalyzer
EXT_DIR="/tmp/firefox-extensions"
mkdir -p "$EXT_DIR"

wget -O "$EXT_DIR/foxyproxy.xpi" https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-7.5.1-an+fx.xpi
wget -O "$EXT_DIR/user-agent-switcher.xpi" https://addons.mozilla.org/firefox/downloads/file/4098688/user_agent_string_switcher-0.5.0.xpi
wget -O "$EXT_DIR/wappalyzer.xpi" https://addons.mozilla.org/firefox/downloads/file/4095500/wappalyzer-6.10.62.xpi

# Install extensions in Firefox
for ext in "$EXT_DIR"/*.xpi; do
    firefox "$ext"
done

# Download web shells
SHELL_DIR="$HOME/shells"
mkdir -p "$SHELL_DIR"

wget -O "$SHELL_DIR/p0wneyWebshell.php" https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php
wget -O "$SHELL_DIR/wwwWebshell.php" https://raw.githubusercontent.com/WhiteWinterWolf/wwwolf-php-webshell/master/webshell.php

# Download Linux and Windows privilege escalation scripts
PESCRIPTS_DIR="$HOME/PEScripts"
mkdir -p "$PESCRIPTS_DIR/Linux" "$PESCRIPTS_DIR/Windows"

# Linux privilege escalation scripts
wget -O "$PESCRIPTS_DIR/Linux/linpeas.sh" https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
wget -O "$PESCRIPTS_DIR/Linux/lse.sh" https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/master/lse.sh
wget -O "$PESCRIPTS_DIR/Linux/LinEnum.sh" https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
wget -O "$PESCRIPTS_DIR/Linux/les.sh" https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh
wget -O "$PESCRIPTS_DIR/Linux/linuxprivchecker.py" https://raw.githubusercontent.com/sleventyeleven/linuxprivchecker/master/linuxprivchecker.py
wget -O "$PESCRIPTS_DIR/Linux/linux-exploit-suggester-2.pl" https://raw.githubusercontent.com/jondonas/linux-exploit-suggester-2/master/linux-exploit-suggester-2.pl

# Windows privilege escalation scripts
wget -O "$PESCRIPTS_DIR/Windows/wes.py" https://raw.githubusercontent.com/bitsadmin/wesng/master/wes.py
wget -O "$PESCRIPTS_DIR/Windows/PowerUp.ps1" https://raw.githubusercontent.com/PowerShellEmpire/PowerTools/master/PowerUp/PowerUp.ps1

echo "Script execution completed."
