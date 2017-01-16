3.16.0-60-generic   MajorRelease=3.Stable=16(geradeZahl).PatchLevel=0.EigeneMakeBezeichnung.
"ln -s /user/src/linux-headers-$(uname -r) /usr/src/linux
Vanilla-Kernel        Pur Linux ohne Hardwareanpassungen
PAE-Kernel            (Physical Address Extension) - angepasst an Rechnerarchitektur 32bit, x86
                      mehr als 4GB physischen Arbeitsspeicher anspricht und generiert.
    monolitischer Kern   - statisch, unflexible, veraltet
    modularer Kern       - dynamischer Kern (anpassbare Modulen)
Level:
    Stable      - stabil, aktuell, 4-6 Monaten support
    Mainline    - Beta, aktuelle und tasting (“-rcX” - Release Candidate LevelX)
    LongTerm    - LongTermSupport - bugfixes, support 1-10 Jahre
    LinNext     - experimentell, neuerungen, nicht veröffentlicht
Components;
    Kernel core      - base Packet-Kommunikation zwischen der Hardware und der Software
    Kernel Objects   - USB-Unterstützung
                     - Dateisysteme
                     - Bildschirm- und Grafikkarten Universal-Untersützung
                     - Terminal Module (VT-100)
                     - NetzwerkTreiber
                     - Ethernet Protokoll
                     - Treiber für CPU und Motherboard
                     - Extended Managing LVM, RAID, LUKS
Essential Packets:
    dkms - Dynamic Kernel Modus Support, hilfstool für selbstcompilierte KernelModules, o.  neuen treiber 
    gcc
    build-essentials
    xz, dtrx packed-file.xz            entpacken
    make               Interprter, der nur im Pfad arbeitet.
    ncurses-dev        Bibliothek für menuconfig
    linux-headers      Linux-Standard-Bibliothekensammlung der aktuellen Kernel-Version 
                       linux-header-$(uname -r)
    Patch-Dateien      evtl. einzuspielende Kernel-Patches
    ksplice            tool für Uptime-Junkies, patching without reboot   
Alte compilerungen bereinigen:
    make                Interprter, der nur im Pfad arbeitet.
        yes             Kernelmodule des alten Kernels mitnehmen.
        no              Kernelmodule aus dem alten kernel nicht aufnehmen.
    make clean          Räumt das /usr/src/linux Verzeichnis auf (.config bleibt  bestehen)
    make mrproper       Räumt das /usr/src/linux Verzeichnis auf (.config bleibt nicht  bestehen)
    make distclean      Räumt das /usr/src/linux Verzeichnis auf (.config bleibt nicht  bestehen, Patches werden entfernt)
    make menuconfig     Zeigt das ncurses-Menü für die manuelle Konfiguration der Mudulen  an und schreibt diese in die Konfig-Datei
    make oldconfig      Wenn sie eine .config-Datei verwenden wollen, die mit einer anderen (älteren) Kernel-Version erzeut wurde,
                        müssen sie diese aktualisieren. Oldconfig fragt interaktiv die konfigurationsoptionen ab.
    make olddefconfig   Standartwerte des alten konfigs werden übernommen
    make oldnoconfig    Die fragen werden verneint
    make config         wenn Fehler, können diese nicht gleich korrigiert werden 
    make xconfig        KDE
    make nconfig        wie menuconfig
    make gconfig        GNOME
Laufende Kernel extrahieren "/boot
    make localmodconfig     
    make localyesconfig   Kernel wird groß, weil laufende Module wersen mitgenohmen
    make dep             Löst die Modulabhängigkeiten auf (depracated)
Compilieren:
    time make           überwachen von make, time messure
    make modules        "Baut" die benötigten Module für den neuen Kernel (modularer Teil)
    make bzImage        "Baut" tatischen Kernel (größer als 512kb, brauch initialen Ramdisk!)
    make zImage         ist kleiner als 512kb, braucht keine initiale Ramdisk
                        - prüft und stelltv Basic software zu Verfügung: Priopriatery Driver (RAID, Virtualisierung, GraphicCards)
Initiale RAM-Disk mit der BusyBox:
    mkinitramfs -o initrd.img-<Kernelversion> <Version>
Reinigen:
    apt-get autoremove && apt-get autoclean 
Module installieren:  
    make modules_install  Kopiert die Module nach "/lib/modules/<Neue Kernel Version>" (installiert diese)
    make modules        Muduleskompilation
    make modules_install Kernel installieren
Kernel patchen:
    bzip2[gunzip] -dc patch-2.5.39-rc4.bz2(gz) | patch -p1 --dry-run    Kernel patchen
    bzip2[gunzip] -dc patch-2.5.39-rc4.bz2(gz) | patch -p1 -R           Patch enfernen
    update-grub
Packete bauen:
    make deb-pkg        ein deb Packet erzeugen
    make birnrpm-pkg    ein rpm Packet erzeugen
Die Vorteile einer Compilierung: 
    -   Der Kernel muss nur ein mal compiliert werden
    -   Der compilierte Kernel kann ausgiebig getestet werden bevor er auf alle anderen Stationen installiert wird
    -   Admin hat eine enorme Zeitersparnis
    -   Arbeitsaufwand sinkt
    -   Vermeidung von Leichtsinnsfehlern, die bei der Konfiguration auf jeder einzelnen Station entstehen könnten
Abschließende Arbeiten:
    -   statischen Teil des Kernels kopieren
        cp /usr/src/linux/arch/[x86[_64]/boot/bzImage /boot/vmlinuz-<Version>
    -   Initiale Ramdisk kopieren (falls nicht in /boot ausgeführt!)
        cp /usr/src/linux/initrd.img-<Version> /boot/initrd.img-<Version> 
    -   Sichern der Konfiguration des zu installierenden Kernel
        cp /usr/src/linux/.config /boot/config-<Version>
    -   Kopieren der Datei mit den Hardwaremapping-Informationen
        cp /usr/src/linux/System.map /boot/System.map-<Version>
    NUR ERFORDERLICH (OPTIONAL) BEI DEBIAN/UBUNTU-BASED DISTRIB.        
        Links in das root-Verzeichnis setzen, falls Grub das /boot- Verzeichnis nicht sofort finden kann
        ln -s /boot/initrd.img-<Version> /initrd.img
        ln -s /boot/vmlinuz-<Version> /vmlinuz
        initrd.old und vmlinuz.old umbenennen!
LILO in /etc/lilo.conf eintragen:
        mage = /boot/vmlinuz-<Version>
        label = <Namen im Bootmenü>
        initrd = /boot/initrd.img-<Version>
        root = /dev/sda2
        vga = 0x314
    /sbin/lilo  ausführen 
GRUB Legacy 
        update-grub
    alternativ
        grub-mkconfig -o /boot/grub/menu.lst
GRUB2
        update-grub
    alternativ
        grub-mkconfig -o /boot/grub/grub.cfg
REBOOT

Troubleshooting:
    Problemfall - "FAST TSC-Calibration failed"
        möglicher Lösungsweg
            ~/ # vi /etc/default/grub
        Zufügen der Zeile
            GRUB_CMDLINE_LINUX=””
        folgenden Eintrag hinzu
            clocksource=acpi_pm
        Welche clocksource möglich ist, ermitteln Sie aus der folgenden Datei:
            "/sys/devices/system/clocksource/clocksource0/available_clocksource
            ~/ # update-grub

