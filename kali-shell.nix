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
    thc-hydra
    john
    hashcat
    medusa
    evil-winrm
    hash-identifier

    # Binary Analysis & Reverse Engineering
    gdb
    radare2
    binwalk
    ghidra
    checksec
    binutils
    volatility3
    foremost
    steghide
    exiftool

    # Python runtime for pip-installed tools
    python3
    python3Packages.pip
  ];

  shellHook = ''
    echo "========================================================"
    echo " Kali Linux Tools Environment Activated"
    echo "========================================================"

    # Isolated pip install directory inside the project
    export PIP_PREFIX="$PWD/.pip-packages"
    PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    export PYTHONPATH="$PIP_PREFIX/lib/python$PY_VER/site-packages:$PYTHONPATH"
    export PATH="$PIP_PREFIX/bin:$PATH"
    mkdir -p "$PIP_PREFIX"

    echo " Installing missing tools via pip..."
    pip install --quiet --prefix="$PIP_PREFIX" \
      autorecon \
      dirsearch \
      patator \
      paramspider

    echo ""
    echo " Nixpkgs tools    : nmap, masscan, rustscan, amass, subfinder,"
    echo "                    nuclei, fierce, dnsenum, theharvester, responder,"
    echo "                    netexec, enum4linux-ng, gobuster, feroxbuster,"
    echo "                    ffuf, dirb, httpx, katana, nikto, sqlmap, wpscan,"
    echo "                    arjun, dalfox, wafw00f, hydra, john, hashcat,"
    echo "                    medusa, evil-winrm, hash-identifier, gdb, radare2,"
    echo "                    binwalk, ghidra, checksec, strings, objdump,"
    echo "                    volatility3, foremost, steghide, exiftool"
    echo ""
    echo " Pip tools        : autorecon, dirsearch, patator, paramspider"
    echo " Pip prefix       : $PIP_PREFIX"
    echo ""
    echo " Omitted          : ophcrack (broken build), crackmapexec (-> netexec)"
    echo "========================================================"
  '';
}
