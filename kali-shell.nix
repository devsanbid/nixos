{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; }; } }:

pkgs.mkShell {
  name = "kali-tools-shell";

  buildInputs = with pkgs; [
    # Network Mapping & Discovery
    nmap
    masscan
    rustscan
    amass
    subfinder
    nuclei
    fierce
    dnsenum
    theharvester
    responder
    netexec
    enum4linux-ng

    # Web Application Security
    gobuster
    feroxbuster
    ffuf
    dirb
    httpx
    katana
    nikto
    sqlmap
    wpscan
    arjun
    dalfox
    wafw00f

    # Password & Authentication
    thc-hydra  # 'hydra' in Nix refers to the CI tool, thc-hydra is the password cracker
    john
    hashcat
    medusa
    evil-winrm
    hash-identifier
    # ophcrack # Currently broken in nixpkgs missing libexpat during build

    # Binary Analysis & Reverse Engineering
    gdb
    radare2
    binwalk
    ghidra
    checksec
    binutils   # Provides strings and objdump
    volatility3
    foremost
    steghide
    exiftool
  ];

  shellHook = ''
    echo "========================================================"
    echo " Kali Linux Tools Environment Activated "
    echo "========================================================"
    echo " Note: The following packages were not found in standard"
    echo " nixpkgs and have been omitted:"
    echo " - autorecon"
    echo " - dirsearch"
    echo " - paramspider"
    echo " - patator"
    echo " - crackmapexec (superseded by netexec)"
    echo "========================================================"
  '';
}
