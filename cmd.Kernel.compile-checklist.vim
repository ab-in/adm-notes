" kernl compile - checklist
" http://wiki.ubuntuusers.de/Kernel/Kompilierung
" http://www.howtoforge.de/anleitung/wie-man-einen-kernel-kompiliert-ubuntu/
" http://www.pro-linux.de/artikel/2/1572/selbstgebacken-kernel-kompilieren-
" nach-rezept.html
" http://lpic2.unix.nl/ch02s02.html (GB)
1. Prerequisite
        - "Kernel-/Patches-Quelle: https://www.kernel.org/
        -  FTP Kernel /Patches:
          "ftp://ftp.kernel.org/pub/linux/kernel/
        -   xz-utils (XZ-Packer - default für Konfigurationstool menuconfig)
        -   gcc (GNU C-Compiler)
        -   libncurses5-dev (ncurses -Bibliothek für halbgrafische Oberfläche)
        -   build-essential dkms linux-headers-$(uname -r) (Standardbibliotheken)
2. Kernel-Sources & Softlink für das Arbeitsverzeichnis holen:
        -   cd /usr/src (Arbeitsverzeichnis)
        -   wget -c https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.14.4.tar.xz
        Wenn Download nicht startet: 
        - Prüfen der Proxy-Einstellungen in /etc/wgetrc!
        - tar xJf linux-<Kernelversion> .tar.xz (Entpacken xz-Packer)
        > es entsteht das Verzeichnis /usr/src/linux-<Kernelversion>
                optional:
        - vi Makefile (Eintrag der Versionsextension unter EXTRAVERSION 
                  zur Identifikation, z.B. -lx81-16);
        - ln -s /usr/src/linux-<Kernelversion> /usr/src/linux (Softlink anlegen)
        - cp /boot/.config /usr/src/linux/ (.config-Datei kopieren)
3. Patches einspielen (optional)
        - Patch download (s.o. FTP)
        - xz -d patch-<Kernelversion>.xz (Entpacken xz-Packer)
        > LPI: Patch-Verzeichnis /usr/src/linux/scripts
        > Realität: Datei wird in /usr/src/ entpackt
        - patch -p1 --dry-run < patch-<Kernelversion> (Patch Testlauf)
        - patch -p1 < patch-<Kernelversion> (Patch-Lauf wenn Testlauf OHNE
          FEHLER)
4. Kernel konfigurieren:
        - make oldconfig (wenn .config noch vorhanden > Kopie aus /boot)
        - make menuconfig (mehere Alternativen, diese ist die praktikabelste >
          ncurses)
5. LPI: Abhängigkeiten erstellen:
        - make dep (dieser Schritt ist seit Kernel-Version 3.11 NICHT mehrnotwendig)
6. BigSize-Image (bzImage) erstellen und kopieren:
        - make bzImage /usr/src/[linux-Source-Files]/arch/x86/boot/bzImagei
        - cp bzImage /boot/vmlinuz-<Kernelversion>
7. Kernel-Module compilieren:
        - make modules (wenn Kompilieren scheitert: alles auf Anfang: make
          clean | make mrproper)
        - make modules && make modules_install
        - cp /usr/src/linux/System.map /boot/System.map-(Version)
8. Kopiere in/boot Verzeichnis:
        - cp /usr/src/[linux-Source-Files]/arch/x86/boot/bzImage /boot/vmlinuz-
          <Kernelversion>
        - cp /usr/src/[Linux-Source-Files]/System.map /boot/System.map-
          <Kernelversion>
        - cp /usr/src/[Linux-Source-Files]/.config /boot/config-<Kernelversion>
9. Initiale RAM-Disk erstellen (und kopieren)
        >>> Ausführen jeweils im /boot-Verzeichnis !
        Debian:
        - mkinitramfs -o initrd.img-<neue Kernelversion> <neue Version aus
        /usr/src/linux-bl>
        Angabe von <Version> notwendig, wenn ANDERE Kernelversion läuft –
        also z.B. 3.14.30!Ansonsten würde der Ordner der aktuell laufenden
        Kernelversion als Quelle der Module referenziert!
10. Installationspakete für den Kernel erstellen – nicht LPI-
    relevant
        - make-kpkg clean (ggf. Paket bc installieren!)
        - fakeroot make-kpkg --initrd --append-to-version=-custom kernel_image
          kernel_headers
        > linux-image-<Kernelversion>-Imagename_i386.deb (> Kernel)
        > linux-headers-<Kernelversion>-Imagename_i386.deb (> Header)
11.Installation:
        - dpkg -i linux-image-<Kernelversion>-Imagename_i386.deb
        - dpkg -i linux-headers-<Kernelversion>-Imagename_i386.deb
        Fedora:
        - yum install dracut
        - dracut initrd-<Kernelversion> <Kernelversion>
        - mv initrd-<Kernelversion> /boot
12. Abschluss:
        1. Überprüfen, ob alle Dateinamen korrekt sind
        2. Bootloadereinträge 
        3.update-grub
        4. Reboot
13. Hoping for the best but expecting the worst...
        - shutdown -r now
        - uname -r
14. Installationpackete erstellen:
        Ubuntu / Debian:
        - cd /usr/src/linux ; make deb-pkg
        Fedora:
        - cd /usr/src/linux ; make binrpm-pkg
15: Praxis:
        Download Vanilla-Kernel
        - get -c <Download-Link> - z.B.
        "https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.0.4.tar.xz
        - apt-get install dtrx (Universal-Entpacker)
        - cd /usr/src/
        - dtrx linux-4.0.4.tar.xz
        Variante 1: 
        Kernel manuell erstellen und konfigurieren:
        - make oldconfig (wenn .config noch vorhanden > Kopie aus /boot)
        oder 
        - make olddefconfig (wenn .config noch vorhanden > Kopie aus /boot)
        ( zu empfehlen bei neuen Konfigurationsmöglichkeiten des Kernels >
        Defaults)
        oder 
        - make menuconfig (mehrere Alternativen, diese ist die praktikabelste >
        ncurses)
        - vi Makefile
        Eintrag der Versionsextension unter EXTRAVERSION - z.B. -lx81-16
        - make clean
        - make dep  (nicht notwendig bei frisch entpackten Vanilla-Kernel)
        - make bzImage
        - cp /usr/src/linux/arch/x86/boot/bzImage /boot/vmlinuz-4.0.4-lx81-16
        - make modules
        - make modules_install - Installation unter /lib/modules/<Kernelversion> -
        hier -4.0.4-lx81-16
        - cp /usr/src/linux-4.0.4/system.map /boot/System.map-4.0.4-lx81-16
        - cp /usr/src/linux-4.0.4/.config /boot/config-4.0.4-lx81-16# mkinitramfs -v -o /boot/initrd.img-4.0.4-lx81-16 4.0.4-lx81-16
        Check: Alle 4 Dateien in /boot vorhanden?
        config-4.0.4-lx81-16
        initrd.img-4.0.4-lx81-16
        System.map-4.0.4-lx81-16
        vmlinuz-4.0.4-lx81-16
        Hinweis:
        ab und an findet man die Aussage in der Fachliteratur, das eine
        initrd NICHT benötigt wird - sofern keine exotischen Treiber genutzt werden.
        Deren Nutzung ist aber spätestens bei virtuellen Maschinen auf Grund der
        propiäteren Treiber der VM-Software der Fall!
        - update-grub
        - shutdown -r 0
        Variante 2: 
        Debian-Installationspaket für den Kernel erstellen (.deb)
        - apt-get install bc
        - make-kpkg kernel_image –revision=lx81-16
        "https://www.youtube.com/watch?v=2EnR4fDPi8w
