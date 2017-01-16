000000000000000000000000000000000000000000000000
00000000 Systeminformationen ermitteln 00000000

0 Inhaltverzeichnis 0
000000000000000000000
    PC-Informationen
    Hardware [-]
        Allgemeine Informationen [+]
        Motherboard [+]
        Steckkarten und PCMCIA [+] 
    Dateisystem [-]
        Rechte
        Dateien/Ordner
        Festplatten [+]
        Partitionen [+]
        USB
        Optische Laufwerke
    Software [-]
        Programmversionen
        Kernel [+]
        Ubuntu [+]
        Benutzer
        Updates / Installationen
        Paketquellen

    # Systeminformationen können auch mit grafischen Programmen ermittelt werden:

    # Gerätemanager - Ubuntu, Kubuntu, Xubuntu

    # restricted-manager - Proprietäre Treiber

    # HardInfo - unter Lubuntu vorinstalliert

    lshw - sehr flexibles Programm, um Komplett- oder Teilinformationen im Terminal zu erzeugen. Es unterstützt u.a. HTML-Tags.

# PC-Informationen

    # Informationen zu Hersteller, Produkt, Version und Fähigkeiten des Mainboards:

    sudo dmidecode -t0 -t1 

	Siehe auch dmidecode.

# Hardware

    # Allgemeine Informationen

    # # Ausgabe von PCI-Karten, Onboard Audio- und Videokartenchips:

    lspci 

    # Ausführliche Hardwareinformationen

    # Erzeugt sortierte HTML-Ausgabe:

    sudo lshw -html > ~/System.html  

    # Eine vollständige Übersicht in kompakter Form liefert:

    sudo lshw -short 

	Siehe auch lshw.

# Motherboard

    # Anzeige von Modell und Hersteller:

    sudo lshw | grep -A6 Motherboard 

    	oder

    sudo lshw -C system 

Eigenschaften

    Ausgabe von Eigenschaften (DMI-Typ 0):

    sudo dmidecode -t0 

    Ausgabe von Eigenschaften , hier nur (U)EFI-Fähigkeit des Mainboards:

    sudo dmidecode -t0 |grep -Ei "(BIOS boot|EFI)" 

# BIOS Version

    # Anzeige von Hersteller, Version und Datum:

    sudo dmidecode | grep -A3 'BIOS Information' 

# Prozessor

    # Anzeige von Bezeichnung, Hersteller und Taktrate:

    sudo lshw -C cpu 

    cat /proc/cpuinfo 

    # Speziell bei der Fragestellung, ob der Prozessor 64-Bit-fähig ist:

    lscpu | grep op-mode 

    	Siehe auch lscpu und 64-Bit-Architektur.

# Speicher

    # Anzeige von Gesamt-, belegter und freier Speicher in MiB:

    free -m 

    # Detaillierter ( Anzeige von L1/L2-Cache, belegte Speicherbänke, Taktrate und mehr):

    sudo lshw -C memory 

# Steckkarten und PCMCIA

    # Für älteren PCMCIA-Karten:

    pccardctl info 

# Audio

    # Erkannte Soundkarte(n) .Je nach verwendeter Ubuntu-Version erfolgt eine Anzeige mit oder ohne Kernelmodul:

    lspci -nnk | grep -i audio -A2     

ALSA-Soundsystem

    # Anzeige von ALSA-Soundtreiber, -karte, -chip, Adressierung:

    cat /proc/asound/cards 

    Siehe auch Sound Problembehebung/Audio-Fehler-Beschreibung sowie den Abschnitt ALSA-Soundsystem im Artikel Videograbbing.

# Grafik

    # Anzeige von Name/Chipsatz (Je nach verwendeter Ubuntu-Version erfolgt eine Anzeige mit oder ohne Kernelmodul):

    lspci -nnk | grep -i VGA -A2 

# Treiberversion

    # Anzeige von Treibername und Version. Unter Umständen muss vorher das Paket mesa-utils installiert werden:

    glxinfo | grep 'OpenGL version string' 

# Grafikmodus

    # Anzeige der aktuellen Auflösung, alle unterstützten Auflösungen und der Anschlüsse:

    xrandr 

    Siehe auch RandR.

# Netzwerk

    # Nameserver-Konfiguration

    cat /etc/resolv.conf 

# Netzwerkhardware

    # Anzeige von Name/Netzwerk-Chipsatz:

    lspci -nnk | grep -i net -A2 

    # Schnittstellenkonfiguration

    ifconfig 

# WLAN

    # Schnittstellenkonfiguration

    iwconfig 

    # Kanaleinstellungen

    iwlist chan 

    # Anzeige erreichbarer WLAN-Netze

    iwlist scan 

# Dateisystem

    # Rechte

    # Anzeige von Besitzer- und Gruppenzugehörigkeit der Dateien/Ordner des Verzeichnisses, in dem man sich gerade befindet:

    ls -la 

    Siehe auch ls.

# Dateien/Ordner

    # Belegter Festplattenplatz:

    du -hs .  

    Siehe auch du oder agedu

    # Freier/genutzter Festplattenplatz:

    df -hT  

    # Die 15 größten Dateien im Verzeichnisse im System auflisten:

    sudo du -kSx | sort -nr | awk '{printf("%7.1f GiB\t%s\n", ($1/1024)/1024,$2)}' | head -15  

    Siehe auch du und Basheinzeiler.

    # Die 15 größten Dateien insgesamt auflisten:

    find / -type f -printf "%k\t %p\n" 2>/dev/null | sort -rn | awk '{printf("%7.1f GiB\t%s\n", ($1/1024)/1024,$0)}' | head -15  

    Siehe auch find und Basheinzeiler.

# Festplatten

    # Bezeichnungen

    # Anzeige der Bezeichnungen /dev/... der angeschlossenen Festplatten/Wechseldatenträger – ohne Partitionen:

    sed -ne 's/.*\([sh]d[a-zA-Z]\+$\)/\/dev\/\1/p' /proc/partitions 

    Siehe auch Wie heißen die Datenträger.

    # Anzeige der Bezeichnungen /dev/... der angeschlossenen Festplatten/Wechseldatenträger – nur Partitionen:

    sed -ne 's/.*\([sh]d[a-zA-Z]\+[0-9]\+$\)/\/dev\/\1/p' /proc/partitions 

    # Anzeige von Bezeichnung, Dateisystemtyp, Label, Einhängepunkt, UUID - hier: alle Datenträger:

    sudo blkid -o list -w /dev/null 

    Siehe auch blkid.

    # Anzeige der Datenträgerbezeichnungen und weiteren Informationen (UUID, Dateisystemtyp, Größe, Label, Einhängepunkt):

    sudo lsblk -o NAME,UUID,FSTYPE,SIZE,LABEL,MOUNTPOINT 

    Siehe auch lsblk.

# Eingehängte Festplatten

    # Anzeige aller eingehängten Partitionen, Mountpoints und Dateisysteme:

    grep "^device /dev/" /proc/self/mountstats 

    Siehe auch mount.

    Wie vorheriger Befehl, aber inkl. der Mountoptionen:

    grep "^/dev/" /proc/self/mounts 

# LVM

    # Anzeige aller eingehängten LVM-Partitionen, Mountpoints und Dateisysteme:

    grep "^device /dev/mapper" /proc/self/mountstats 

    # Anzeige von Physical Volumes, VG, Fmt, Attr, PSize, PFree:

    sudo pvs 

    Siehe auch Logical Volume Manager

    # Anzeige von Volume Groups, #PV, #LV, #SN, Attr, VSize, VFree:

    sudo vgs 

    # Anzeige von Logical Volume, VG, Attr, LSize, Origin Snap%, Move, Log, Copy%:

    sudo lvs 

# RAID

    # Anzeige aller eingehängten RAID-Partitionen, Mountpoints und Dateisysteme:

    grep "^device /dev/md" /proc/self/mountstats 

    # Kurze Übersicht des RAIDs:

    cat /proc/mdstat 

# SWAP

    # Anzeige von Swap-Filename, -Typ, -Größe, -Nutzung, -Priorität:

    swapon -s 

    Siehe auch Swap.

# Partitionen

    # Anzeige von Bezeichnung, Größe, Belegung, Einhängepunkt:

    df -h 

    Siehe auch df.

    # Anzeige von Bezeichnung, Dateisystemtyp, Label, Einhängepunkt, UUID – hier: alle Datenträger:

    sudo blkid -o list -w /dev/null 

    # Alternative Darstellung mit lsblk (zusätzlich noch mit der Größe):

    sudo lsblk -o NAME,UUID,FSTYPE,SIZE,LABEL,MOUNTPOINT 

    # Zeige mit lsblk alle für den gewöhnlichen Benutzer/Admin interessanten Attribute:

    sudo lsblk -o NAME,FSTYPE,UUID,RO,RM,SIZE,STATE,OWNER,GROUP,MODE,TYPE,MOUNTPOINT,LABEL,MODEL 

# Partitionierung

    # Achtung! Bei den Abfragen zu Partitionstabellen muss - sofern im Einzeiler angegeben - 
	der Datenträger sda jeweils auf die eigenen Anforderungen angepasst werden!

    # Anzeige von Modellname, Partitionstabellenschema, Bezeichnungen, Reihenfolge, Größe, Typ, 
	Dateisystem, Bootflag (in Bytes) – alle angeschlossenen Datenträger:

    sudo parted -l 

    Siehe auch GNU Parted.

    # Anzeige von Modellname, Partitionstabellenschema, Bezeichnungen, Reihenfolge, Größe inkl. eventuellem freien Platz, 
	Typ, Dateisystem, Bootflag (in Bytes und als Sektoren):

    sudo parted -s /dev/sda print free unit s print free   

    Siehe auch GNU Parted.

MBR-Partitionstabelle (MPT)

    # Anzeige von Disk identifier, Bezeichnungen, Reihenfolge, Sektoren, Bootflag:

    sudo fdisk -lu /dev/sda   

    Siehe auch fdisk.

    # Anzeige von Disk identifier, Bezeichnungen, Reihenfolge, Sektoren, Bootflag – alle angeschlossenen Datenträger:

    sudo fdisk -lu 

    Siehe auch fdisk

    # Anzeige des MBR in Form eines Hexdump:

    sudo hexdump -n512 -C /dev/sda  

# GUID-Partitionstabelle (GPT)

    # Anzeige von Disk identifier, Bezeichnungen, Reihenfolge, Sektoren, Bootflag:

    sudo sgdisk -p /dev/sda  

    Siehe auch gdisk

    # Anzeige von Disk identifier, Bezeichnungen, Reihenfolge, Sektoren, Bootflag – alle angeschlossenen Datenträger:

    while read -r device;do sudo sgdisk -p $device;done < <(sed -ne 's/^.*\([sh]d[a-zA-Z]\+$\)/\/dev\/\1/p' /proc/partitions) 

    # Anzeige von erweiterten Informationen aller Partitionen:

    sudo sgdisk -i1 /dev/sda 

    Siehe auch gdisk

    # Anzeige des Primary-Headers einer GPT in Form eines Hexdump:

    sudo hexdump -s512 -n512 -C /dev/sda  

    #  Anzeige der ersten 8 Partitionen-Einträge einer GPT in Form eines Hexdump:

    sudo hexdump -s1024 -n1024 -C /dev/sda 

    # Anzeige des Secondary-Headers einer GPT in Form eines Hexdumps:

    d=sda ; sudo dd if=/dev/$d skip=$\(($(sudo sgdisk -p /dev/$d|sed -ne 's@^.* /dev/'$d': \([0-9].*\) s.*$@\1@p')-1)) 2>/dev/null|hexdump -C 

# UUID

    # Anzeige von Bezeichnung, UUID, Label und Dateisystemtyp:

    sudo blkid -w /dev/null 

    # Anzeige von Bezeichnung, Dateisystemtyp, Label, Einhängepunkt, UUID:

    sudo blkid -o list -w /dev/null 

    # Alternative Darstellung mit lsblk:

    sudo lsblk -o NAME,UUID,FSTYPE,SIZE,LABEL,MOUNTPOINT 

# USB

    # Anzeige aller Anschlüssen und angeschlossener Geräte:

    lsusb 

    # Alternativ:

    usb-devices 

    # Detaillierte Informationen zum angegebenen Gerät (IDs werden von den obigen Befehlen lsusb und usb-devices angezeigt):

    lsusb -vd HerstellerID:ProduktID 

# Optische Laufwerke

    # Anzeige detaillierter Informationen zu optischen Laufwerken:

    sudo wodim -prcap 

# Software

    #  Installierte Version von PAKET/PROGRAMM:

    # dpkg-query -W PAKET 

    # PAKET muss dabei durch den gewünschten Paketnamen ersetzt werden 
	(z.B. python3, wenn man Informationen zum Python 3 Paket haben möchte). 
	Weitere Informationen zur Zusammensetzung der Versionsnummern sind im Artikel Versionsnummern von Ubuntu-Paketen zu finden.
   
# Kernel

    # Anzeige von Kernelversion und Systemarchitektur:

    uname -rm 

    # Nur die Systemarchitektur:

    lscpu | grep -i architecture 

    x86_64 steht für eine 64-Bit-Version. Siehe auch uname und lscpu.

    # Anzeige geladener Kernelmodule:

    lsmod 

    # Kernelmeldungen

	Genauer: die Meldungen des Ringpuffers des Kernels. Siehe dmesg.
	Ubuntu

    # Anzeige der Ubuntuversion, Release und Spitzname:

    lsb_release -a 

    oder

    cat /etc/lsb-release 

