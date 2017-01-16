--------mounten
mount   Steuerungs- und Abfrageprogramm des Dämons mountd. 
        Ein- und Aushänge-vorgänge in einem Linux-System kümmert.
        "mount -t ext3 -o /dev/sdb1 /Files
        alle aktuell im System eigehängte Datenträger werden ohne Schalter  angezeigt
        "/etc/mtab, oder  /proc/mounts 
    -t <Typ>    Dateisystemtyp
    -a          liesst /etc/fstab und mountet Gerä#te mit "auto" Optionen.
    -o <Option,en> übergibt Mount-Optionen
    -v          Verbose. Gibt Bestätigung des mount-Vorgangs aus.
    -r          “read-only”  alternativ: -o ro
    -w          “read-write” alternativ: -o rw
                rw - default wenn keine Option angegeben!
    "-r & -w | -o rw | -o ro
        Der Einsatz der Schalter -r oder -w bietet sich dann an, wenn dem
        Kommando keine weiteren Optionen (also der Schalter -o) über-
        geben werden.
        Wird jedoch bereits eine Option mit dem Schalter -o übergeben, so
        ist es besser, den Optionen ,rw oder ,ro anzuhängen. Dies erhöht
        die Lesbarkeit des Kommandos
        "mount -v -o remount,rw /dateien
umount /boot        mount mountpoint
umount /dev/sda1    umount Gerät
----------Netzwerklaufwerke mounten
    apt-get install cifs-utils (für Samba)
        "mount -t cifs //192.168.2.117/Daten /nas -o username=datauser,password=secret,rw
        "mount -t cifs //192.168.2.117/Daten /nas -o credentials=/home/vm/.credentials,rw
"/etc/fstab" " Automatisches mounten. Mount Optionen:
    auto/noauto         ermöglicht autom. Anhängen mount -a)
    usrquota/grpquota   aktiviert/deaktiviert die benutzung von Quotas
    suid/nosuid         funktionen des SUID
    exec/noexec         erlaubt das Ausführen von Dateien auf diesem System
    ro/rw               read/write-only
    user/nouser         erlaubt dem normalem user das Anhängen, nur er und root kann aushängen.
    users                   -||-                                alle können aushängen
    defaults            rw,suid,dev,exec,auto,nouser,asymc
    owner               nur der owner des devices und root dürfen An-Aushängen
    nofail              unterdrückt Fehlermeldungen
    errors=remount-ro   tritt ein Fehler auf, wird read-only als Sicherheit gesezt
    sync                der Schreibcache wird deaktiviert. Nach JEDEM
                        Schreibvorgang wird das Kommando sync
                        ausgeführt und damit das physikalische
                        Schreiben der Daten auf die Festplatte
                        erzwungen. Sinnvoll für USB-Datenträger. Es verhindert
                        einen evtl. Datenverlust bei abstecken des USB
"Spalte 1 Geräte- / Partition
        /dev, UUID, Label können als Bezeichnung eingetragen werden.
"Spalte 2 Einhängepunkt
        Besonderheit bildet hier das swap-Laufwerk! Es wird nicht direkt auf das Dateisystem
        gemountet, sondern an einen virtuellen Punkt /swap, der aus dem Userland nicht direkt ansprechbar ist!
"Spalte 3 Dateisystemtyp ( /swap beachten!)
"Spalte 4 Optionen des mount-Vorgangs (ro,exec..usw.)
"Spalte 5 hier wird angegeben, ob dieses Laufwerk bei
        einer Datensicherung mit dem Kommando dump mit
        gesichert werden soll.
        1 = ja - 0 = nein
"Spalte 6 fsck (file system check)
            0 = nie prüfen
            1 = Defaultwerte:
                alle 36 mount-vorgänge oder alle 180 Tage geprüft
            2 = der Datenträger wird erst dann geprüft,
                wenn alle mit 1 gekennzeichneten
                Datenträger regulär geprüft wurden.
----------Swapping
swapon -a, -U, -s /dev/sd*<pagesile.sys> (alles aus fstab, UUID, status)
swapoff           /dev/sd*
pagefile.sys    "dd if=/dev/zero of=/pagefile.sys bs=100M count=3
                "mkswap /pagefile.sys, swapon /pagefile.sys, swapoff /pagefile.sys
                "less /proc/swaps oder swapon -s     (status abfragen)
                "free [ -hlt ]
----------DateisystemPflege
ext-DateiSysteme:
    fsck -option   /dev/sdb1
    -f  force - zwingt Prüfung
        wenn man die Prüfung unterbinden möchte, dann "shutdown -hf now
    -A  all - testet fstab
    -t  Dateisystemtyp (wählt passendes Back-End zu)
    -c  check nach defekten Blöcken
    -b  Blocknummer (alternativer Superblock)
    -y  beantwortet alle Fragen des Programms mit Yes
    fsck.ext2
    fsck.ext3
    fsck.ext4 - link auf e2fsc
xfs-Dateisysteme:
    fsck.xfs
        DEB: apt-get install xfs-progs [ xfsdump ]
        RHEL: yum install xfsprogs [ xfsprogs-devel xfsdump ] 
        modprobe xfs - wenn fehler (meinst fehlender Kernelmodule)
Windows/DOS-Dateisysteme:
    vfat & dos
    sck.vfat
    fsck.msdos -  Link auf dosfsck
    fsck.ntfs-3g
Sonstige Dateisysteme:
    fsck.minix  - Minix-FS
    fsck.jfs    - JFS
    fsck.cramfs - CramFS
----EXT2, EXT3, EXT4:
    tune2fs -L "mylabel" /dev/sda1      Label der Festplatte hinzufügen > /dev/disk/by-label
    tune2fs -j /dev/<ext2-Device>       fügt dem Datenträger das Journaling hinzu - aus ext2 wird ext3
        "Bei ext-Dateisystemen solte mind. 500Mb frei gelassen werden um ein Wartungarbeiten bei vollen Festplatten zu machen.
        "5% von Hauptpartition (500-600 MB), auf anderen 0,2% oder 0
    tune2fs -m 5.4 <Partition>          Die Angabe erfolgt in %
    tune2fs -r 24587 <Partition>        Die Angabe in der Einheit “Blöcke” (Ganzzahl)
    tune2fs -g <Gruppenname || GID> <Partition>   Den Speicherplatz an die Gruppe übertragen
    tune2fs -o <Benutzername || UID> <Partition>  Übertragung an eine bestimmte Person
    tune2fs -l                          Superblock Informationen
    tune2fs -i <NUM>                    interval zwischen der Prüfungen: Tagen, Wochen, Monaten
    tune2fs -c <NUM>                    nach wieviele Mounts soll die Platte geprüft werden
    debugfs  /dev/sd*                   interaktives Tool für Analyse der ext* Dateisysteme
    debugfs: lsdel                      zeigt gelöschte inodes
    debugfs: dump <13> /tmp/restored    inode wiederherstellen (dann mounten und die Datei reinkopieren)
Bash Trash Script für unabsichtiges Löschen:
        function rm() {
            for i in $@
                do
                mv $1 ~/.bashtrash
                shift
                done
                }
    dumpe2fs /dev/sda1 | less       detaillierte informationen
    mke2fs -c <Device>              prüft Integrität der Festplatte (Verbose)                       
    mke2fs -n <Device>              alternative Auslesen (wie Verbose)
    e2fsck -c <ReserveSuperblock>   erzwingen von Benutzung des Reserverblocks (dann mounten)
    mke2fs -S <Device>              im Notfall schreibt den Superblock neu
    e2fsk -a  <Device>              obligatorisches Prüflauf um die Dateizuordnungstabele neu einzulesen. 
        "In allen Fällen sollte im Erfolgsfall umgehend die Festplatte nur lesbar gemountet werden 
        "und eine Datensicherung der GESAMTEN  Festplatte (nicht nur diese eine Partition!) durchgeführt werden!
----REISE-FS
    debugreiserfs       entspricht debugfs für ext
    reiserfstune        entspricht tune2fs für ext
    -u                  ändert die UUID
    -l                  ändert den Bezeichner des DT (Volumename)
    -c                  ändert das Prüfungsintervall für fsck
----XFS - robustes Dateisystem. Das Journal ist auf einen separaten Datenträger augelagert.
       Möchte man von einer Festplatte, die mit xfs-Formatiert ist booten, 
       so müssen zwingend die Module für xfs statisch in den Kernel kompiliert werden
    apt-get install xfsprogs [ xfsdump ]
    xfs_info            zeigt Informationen über ein XFS FS an
    xfs_check           prüft ein XFS-FS (ersetzt durch xfs_repair -n) deprecated.
    xfs_repair          repariert ein XFS-FS
    xfsdump             Datensicherung, welches speziell auf XFS-Datenträger zugeschnitten ist -
                        performant und behält alle Dateiinformatione und Attribute
    xfsrestore          das Gegenstück zu xfsdump
----BTRFS (better-fs, butter-fs) BTree-FileSystem von Oracle
   - "maximale Gr 16 EiB (z.Vgl. ext4 2^48 Byte)
   - "Journaling
   - arbeitet effektiver und schneller mit kleineren Dateien
   - "Snapshot-Funktionalität
   - "integriertes RAID-System
   - "Datenkompression (LZO & zlib)
   - Optimierung für SSDs out-of-the-box
   - Anzahl der iNodes nicht mehr begrenzt
   - werden dynamisch erstellt und verwaltet
   - FileSystem-Check und Defragmentierung im laufenden Betrieb möglich
   - "Copy-on-Write (COW) http://de.wikipedia.org/wiki/Copy-On-Write
   - Verwaltet intern Metadaten je Datei und Verzeichnis
   - schnellere Zugriffszeiten auf Daten
   - "Mehrere Würzelverzeichnisse - Subvolumes (abweichende neue Quotaverwaltung)
   - Möglichkeit einzelne Unterverzeichnisse mit Laufwerkscharakter einzuhängen (realisiert durch Subvolumes)
   - FileSystem-Check ist  effizient und sehr schnell, beschleunigt den Systemstart
   - Konvertierungsmöglichkeiten von und nach ext(4) dadurch Testmöglichkeiten gegeben.
apt-get install btrfs-tools
yum install btrfs-progs
    -FileSystemCheck mit DEB:     fsck.btrfs
                       RHEL:    btrfsck
    -Konvertierungstool           btrfs-convert
    -Hauptverwaltungstool         btrfs
    -Meta-Datenbaum auslesen      btrfs-debug-tree
    -Image-Tool                   btrfs-image
    -Rücksichern mit dd möglich!
    -Dateisystem anlegen          mkfs.btrfs
----------------Dateisysteme erzeugen

