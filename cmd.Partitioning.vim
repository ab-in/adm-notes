Tools        
    fdisk
    cfdisk      Frontend zu fdisk.
Partitionstypen
        82  ⇒   Linux SWAP
        83  ⇒   Linux ( allgemein für ext, reiser, xfs … )
        8E  ⇒   Linux LVM
        FD  ⇒   Linux RAID ( Software-RAID! )
Erstellen eines Dateisystems (Formatieren)
    mkfs.<fs>
    fdisk <Device>
        -l  List Partitions
        -h  Hilfetext
        -s  Zeigt die Größen der Partitionen
Device identifizieren
    ls -l /dev/<hd*> || ls -l /dev/<sd*>
    CD-ROM und DVD  "/dev/sr*   
    less /proc/partitions
    fdisk <Device> ohne Schalter - wechselt in den interaktiven Modus (:)

        a   Partition als bootable markieren (an/aus)
        d   Partition entfernen
        l   PartitionsTYPENtabelle anzeigen
        n   neue Partition hinzufügen - Typ, Größe, etc.
        p   Partitionstabelle für das Device anzeigen
        q   beendet fdisk (Änderungen werden verworfen!)
        t   Partitionstyp ändern
        u   Anzeige der Einheiten werden geändert (MB,Blocks…)
        v   überprüft die Partitionstabelle
        w   schreibt die durchgeführten Änderungen auf das Device und beendet fdisk
        x   erweitertes Hardware-Menü
            2.
            Partition
            ggf.
            xfs
            nachladen
            apt-get
            install
            xfsprogs
            mkfs.xfs
            /dev/sdc2
            Die
    Ausgabe
(
 Erfolgsmeldung
 )
    von
    xfs
    ist
    im
    Vergleich
    zu
    mke2fs
    anders.
    Die
    Formatierungs-
    zeit
    ist
    auch
    wesentlich
    geringer.
    xfs
    eignet
    sich
    auf
    Grund
    seiner
    Stabilität,
    Robustheit
    und
    Geschwindigkeit
    hervorragend
    als
    Dateisystem
    auf
    Realtime-Systemen!
    Die
    neuen
    Partitionen
    mounten
    mount
    /dev/sdc1
    /ext2fp
    mount
    -t
    xfs
    /dev/sdc2
    /xfsfp
    Bei
    nachträglich
    geladenen
    Dateisystemen
    - wie
    hier
    xfs
    - kommt
    es
    durchaus
    vor,
    dass
    mount
    den
    Dateisystemtyp
    nicht
    selbst
    herausfinden
    kann.
    Dann
    muss
    mit
    -t
    explizit
    der
    Typ
    angegeben
    werden
    -           ebenfalls
    unbedingt
    notwendig,
    wenn
    Netzlaufwerke
    oder
    Netzfreigaben
    gemountet
    werden
    sollen!
    TIPP
    zum
    Herausfinden
    des
    FS-Typs:
    Um
    herauszufinden,
    um
    welches
    Dateisystem
    es
    sich
    bei
    einer
    Partition
    handelt,
    eignet
    sich
    blkid.
    Es
    wird
    in
    Klartext
    angegeben,
    um
    welches
    Dateisystem
    es
    sich    
    handelt.
    Sollte
    ein
    ext2-System
    mit
    Journaling
    ausgerüstet
    worden
    sein
    - also
    nun
    ext3
    entsprechen,
    so
    steht
    noch
    zusätzlich
    der
    Schlüssel
    SEC_TYPE
    auf
    ext2!
    Daran
    kann
    man
    ein
    konvertiertes
    System
    kennen!
