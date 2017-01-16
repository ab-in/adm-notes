man <Kommando>	        Manual-Seiten für das Kommando
man -k <Suchbegriff>	apropos
manpath	                Ausgabe Pfad Manuals
manpath -c	            Ausgabe Pfad Cacheverzeichnis Manuals 	
whatis ls	            Namensfeld durchsuchen nach ls
apropos                 Beschreibungsfeld   durchsuchen nach ls
grep -i	                ignoriert Case Sensitivity
grep -e	                Regular Expression
grep -v	                Negiert	
which ls	            Pfad des Programms
whereis	                Pfad und Zusatzinformationen
-------------------------
pwd                 	parent working directory
cd	                    change directory
cp -i	                Kopieren/Nachfrage interaktiv
cp -r	                Kopieren/Rekursiv
mv -i	Verschieben/Nachfrage interaktiv
mv -f	Verschieben/Ungefragt überschreiben
rm -i	Löschen / Nachfrage interaktiv
rm -f	Löschen / Erzwingen
rm -r	Löschen / Rekursiv
mkdir -p	Erstellt auch Überverzeichnisse, wenn nicht da
mkdir -v	Zusatzinformation
rmdir	Löschen Leerer Ordner
split -b	Datei zerlegen m(MB) k(KB) g(GB)
cat Concatternate More Files
tac	Ausgabe rückwärts
more	MOER Pager - Show more lines
less	LESS Pager - Show me at least one page
less -N	LESS Pager - Zeilennummerierung
less -S	LESS PAGER Zeilenumbruch verhindern
tail	Dateiende ausgeben
tail -n	zeigt die Anzahl übergebener Zeilen an
tail -f	aktualisierte Ausgabe Dateiende
head	Dateianfang ausgeben
head -n	zeigt die Anzahl übergebener Zeilen an
od	octal dump
hexdump	hexdump
ls	list files
ls -l	Anzeige in Langform / Listenform
ls -1	Vertikale 
ls -a	Alles ausgeben  , auch verborgene
ls -h	HumanReadable
ls --si	Potenz 1000
ls -d	Nur Verzeichnisse
ls -g	gibt die Gruppe aus
ls -R	Rekursive Ausgabe
ls -s	Größtenangabe in Blöcken
ls -i	zeigt zusätzlich INODE
chmod chmod 755 Datei
chmod chmod u=rwx,g=rx,o=rx
chmod	chmod u+wx,g+x,o+x
chmod	chmod o-r
chmod	chmod a+x
chmod	chmod +x
-----------------------
SDTIN	Standard Eingabe   0 Tastatur
STDOUT	Standard Ausgabe  1 Monitor 
SDTERR	Standard Ausgabe  2 Monitor 
<	Einlenkung
>	Umlenkung
|	Pipe
tee	Pipe inkl. STDOUT
xargs	CrossArguments
expand	wandelt alle Tabstopps in eine Leerstelle um
unexpand	wandelt Leerstellen in Tapstopps um
nl	Number Lines
wc	WordCount 
wc -c	Bytes
wc -l	Zeilen
wc -w	Wörter
wc -m	Zeichen
sort	sortieren
sort -n	Sortierung numerisch
sort -o	Sorterierung Pfad Output/Ausgabedatei
sort -r	Umgekehrte Reienfolge
uniq	Doppelte Einträge entfernen, vorher sort
cut	Ausschneiden
cut -d":"	Spalten definieren Trennzeichen :
cut -f1-10	Spalten 1-10 ausschneiden und STDOUT
cut -f1,2,3,7,8,9	Spalten 1,2,3,7,8,9 ausschneiden und STDOUT
paste	Datei ineinander kopieren und STDOUT
paste datei1 datei2	Datei ineinander und SDTOUT
join	-t\; datei1 datei2	Datei ineinander kopieren mit Primärschlüssel
join -t\; -j 2 datei1 datei2	Primärschlüssel in Zeile 2
tr Translate
tr -d "X"	Entfernt alle X
tr -s "X" ["Y"]	
tr -t "X" "Y"	Zeichen X wird durch Zeichen Y ersetzt
fmt	simple format text
pr	printfile
----------------Variables
set var=inhalt	Shell-Variable definieren
var=inhalt	Shell-Variable definieren
unset var	Shell-Variable löschen
export var=inhalt	Export und Definiton der Shell-Variable SubShell
export var	Export der Shell-Variable für SubShell
echo $var	Ausgabe der Variable var
alias abc='ls -al'	Alias abc definieren für ls -al 
unalias abc	Alias abc löschen
unalias -a	Alle Aliase löschen
command	Umgehen der Aliasfunktion
builtin	Umgehen der Aliasfunktion
source /etc/bash.bashrc	Neu einlesen der Datei /etc/bash.bashrc
touch	Datei anfassen
------------Searhc
find -name Abc	sucht nach Dateinamen *Abc*
find -iname Abc	sucht nach Dateinamen nicht case sensitive
locate	Suchen in Suchdatenbank
updatedb	Suchdatenbank aktualisieren
file	Dateiinformationen
------------Compressing
tar	Packprogramm Tape Archiver 
tar -f <Datei>	gibt den Dateinamen der Quell/Zieldatei an
tar -c	create
tar -x	extract
tar -z	GZIP	.tar.gz   .tgz    .tar.z
tar -j	BZIP2	.tar.bz2 
tar -J	XZ	.tar.xz
tar -t	Inhalt des Archis ausgeben (table)
tar -v	verbose
dd	    Device-To-Device-Copy
---------------Quotas
activate user root and changing to root console: "sudo passwd root", "sudo usermod -U root", "su - root"
adding to fstab "usrquota,grpquota"
mount /dev/sda /home -o remount
service quota restart
touch aquota.user aquota.group
chmod 600 aquota*
scanning quotas: "quotacheck -avug"
quotaon -av (-avug) (-F vfsv0)
checking Blocks with "dumpe2fs -h /dev/sd* | grep "Block size""
changing limits: edquota -f /home -u username
checking quota status as user: quota
printing status: repquota -avug /home
-------------Administration
chroot  startet eine Shell in einem veränderten Wurzelverzeichnis 
chsh    verändert die Default-Shell eines Benutzers
getent  liest datenbank aus nsslibrary (services,networks,shadow,hosts,protocols,group,aliases,netgroup...)
groupadd
groupdel            gruppen lösschen
groupmod            gruoppen modifizueren
groupmod -A         add user
groupmod -R         remove user
groupmod -n         name ändern
chage -m 2 user     bestimmt Alter des passwd
pwgen               generiert leicht merkbare Passwörter
passwd              setzt userpasswort
gpasswd             group passw setzen
gpasswd -r          gpasswd remove
pwconv / gpwckconv          verschiebt passwd to shadow
pwunconv / grpunconv        verschiebt von shadow nach passwd
pwck / grpck         prüft konsistenz /etc/passwd/shadow
useradd
userdel
usermod
chfn        userinfo ändern
finger      
newgrp      user ändert die grouppenzugehörigkeit
id	        zusätzlich UID/GID/Gruppenmitgliedschaften
id -u       user ID des angemeldeten user
------------AuthoAdmin
crontab -e  jobs verwalten wie bei logrotate
crontab -l  listet jobs
crontab -r  löscht crontab tabelle
crontab -u  root can die crons von anderen user ansehen und bearbeite
crontab     verzeichnisse /etc/cron, /etc/crontab, cron.allow, cron.deny, /var/spool/cron
at          jobs verwalten einmalig
atq         jobs werden nachgeholt na dem reboot
at          führt einen Job zu einem vordefinierten Zeitpunkt aus
atq         listet Jobs auf, die später ausgeführt werden sollen
atrm        löscht einen Job, der später ausgeführt werden soll 
watch       führt einen Job aus, sobald das System im Leerlauf läuft 
bg          setzt einen Prozess im Hintergrund fort
fg          setzt einen Prozess im Vordergrund fort
fuser       ermittelt das Programm, das auf eine Datei zugreift
halt        beendet Linux und hält den Rechner an 
ionice      steuert die I/O-Priorität eines Prozesses 
iotop       zeigt die Prozesse mit der größten IO-Aktivität an 
anacron     jobs werden nachgeholt na dem reboot
--------------Locales
iconv       convertiert zeichensatz
iconv --from-code 
iconv --to-code
iconv -l                list der Zeichensätze
tzselect                zeigt verfügbaren Zeitzonen interaktiv
tzconfig                frontend zum einstellen von Zeitzone
dpkg-reconfigure tzdate     frontend zum einstellen von Zeitzone
locale -a               zeigt Lokalisationen an
locale -m | head        liste verfügbaren Zeichensätze
date -s 1755            manuelle konfig der Systemzeit auf 17.55Uhr
hwclock --systohc       konfig. Zeit von system to hardware
hwclock --hctosys       konfig. Zeit von hardware to system
hwclock --show          vergleichen der Zeit zwischen system  and hardware
ntp                     Network Time Protokol mit server pool
ntpq -p                 Diagnosetoll - welche Server spools wurden verbunden  
ntpdc                   Diagnosetool -Abfrage nach sysinfo 
ntpd                    Dämon
ntpdate                 mit cron fürht automatisch systemzeitsynchronisation 
logger -t<tag>          "Datensicherung durchgeführt"   Ereignisse  in den Syslog eintragen
logger -p<facility level>   default: notice
logger<Text>            "Mein Text"
-------------Hardening
find /usr -uid 0 -perm +4000        search FIles with SUID from user root
find /usr -uid 0 -perm -u+s         search -||-
find / -size +30M               find Dateien größer als 30MB
/etc/shadow
    * konto aktiv, aber access nicht möglich
    ! konto deaktiviert, kein login und keine DIenste
    x passwort eingetragen in der shadow
netstat             offne und lauschen Ports anzeigen. von lokalen Rechner
ss                  open & listen Ports anzeigen
socket              prüft aktive/deaktivierte Dienste
nmap                Portscanner
df                  disk free
du                  Speicherbelegung
free   -k,-m-g (KB,MB,GB)     Arbeitsspeicher
ulimit              get and set user limits
ulimit -c           max.Gr. für core files
ulimit -d           max.Gr. für ein Programm
ulimit -[H|S]n 800  Anzahl der maximal gleichzeitig geöffneten Dateien auf einen Wert von 800 einschränken
ulimit -Ht10        Einem Benutzer nur 10 Sekunden CPU-Zeit pro Minute zuweisen
ulimit -Sn 1200     sein Limit vom Softlimit (1000) bis an das Hardlimit 1200) setzen
lsof /mnt/nas       Geöffnete Dateien auf dem System ermitteln
lsof -i :22         lsof auf einem Port      
lsof | wc -l        wieviele geöffnete Dateien
kill -s 9 $(lsof -t /media/disk-1)      alle Prozesse die blockieren auf ein mal killen    
fuser               Alternative zum lsof
fuser -m -u /home/user/test   zeigt das Prozess der file, sockets, filessystems
su                  ohne schalter unsicher wenn login vergessen..
su -c               fragt nach root passwd für eine cmd
visudo              modifiziert /etc/sudoers 
EDITOR=vi sudo -E visudo        cmd und variable zugleich
sudo                wird gelogt, <Benutzer> ist nicht in der sudoers-Datei. Dieser Vorfall wird gemeldet
sudo -i             es wird eine interaktive Login-Shell estartet. Roots .bashrc, usw. sind in dieser Shell gültig!
sudo -s             subschell mit Rootrechten. Aliase, einstelungen bleiben erhalten
last                verrät, wer zuletzt auf diesem Rechner eingeloggt war (/var/log/wtmp o. btmp)
w                   wer ist angemeldet   /var/run/utmp
whoami	            Eigene Identität
who                 liefert Informationen über die eingeloggten Benutzer
who -u -s -b -d -l  user, short, boot, dead, login
uptime              wie lange war das system online. -s (--since)
-------------Security/Crypto
ssh-keygen -t dsa/rsa/rsa1          generiert Schlüssel (id_dsa und id_dsa.pub)
cat ssh_host_dsa/rsa_key.pub >> /etc/ssh/ssh_known_hosts
cat <DSA-Schlüssel> >> $HOME/.ssh/authorized_keys   - Anmeldung ohne Passwort
    dsa - Sygnatur         "/etc /ssh/ssh_host_dsa_key
    rsa - Verschlüsselung  "/etc /ssh/ssh_host_rsa_key
scp [ -P port ] <RSA & DSA-pub-keys> user@remote:/Ziel-Ordner
ssh-add     fügt weitere Schlüssel hinzu - fragt nach Passphrase
    -l  listet Fingerabdrucke
    -d  entfernt einen Schlüssel
    -D  entfernt alle Schlüssel
    -s  listet key von einer Smartcard
    -e  entfernt key von Smartcart
    -x  sperrt Agenten
    -X  entsperrt
ssh [ Schalter ] [user@]<Zielhostname oder IP> [ Kommando ]
    -l      user  (alternativ user@hostname)
    -X      X-Window Übertragung
    -1      Protokoll 1 erzwingen
    -2      Protokoll 2 erzwinge
    -L      <[IP:]lokalPort:remoteIP:remotePort>  - Tunnel
    -R      Tunnel umgekehrtter Richtung
    -y      Fehlermelungen nicht in stderr sondern  auf syslog
ssh-copy-id     kopiert die Identität (PublicKey) auf den Server
sshfs       mounten von fernen Systemen
gpg --gen-key   generiert pgpSchlüssel in ~/.gnupg
    pubring.gpg   - public key
    trustdb.gpg   - Key anderen Benutzer
    secring.gpg   - geheim Schlüssel
gpg --encrypt file    (ID Abfrage)
gpg --decrypt file.gpg > file   (Passphrase Abfrage)
gpg --gen-revoke harald     Zertifikat wiederrufen, auf anderem Medium speichern
gpg --import revokefile.txt
sh-agent
    -x  sperrt den ssh-agent
    -X  entsperrt den ssh-agent (Sperrpasswortangabe)
    -d <key> löscht den angegebenen Fingerabdruck
    -D  entfernt alle Fingerabdrücke aus dem ssh-agent
    [-s]    liest den Schlüssel aus einer SmartCard
    [-e]    entfernt den Schlüssel der SmartCard
ssh -Xf host xterm
    öffnet ein XTerminal dass auf der eigenen Maschin  angezeigt wird, aber auf der anderen (> Server) läuft
    # scp [ -P port ] <RSA & DSA-pub-keys> user@remote:/Ziel-Ordner
    sicheres, weil verschlüsseltes, Kopieren von Dateien   ähnlich wie "rsync".
-------------System Information- tools
Punktuelle Auswertung:
    cat /proc/cpuinfo   ||  lscpu | lspci  lsblk
    cat /proc/meminfo       free (zeigt Swapspace mit an)
    lsusb -v        usb devices    
    sync; sync; sync; echo 3 > /proc/sys/vm/drop_caches   - cache freigeben
    free && sync && echo 3 > /proc/sys/vm/drop_caches && free  - empty buffer
    echo 1 > /proc/sys/vm/drop_caches -  pageches
    echo 2 > /proc/sys/vm/drop_caches -  dentrieds, inodes
    echo 3 > /proc/sys/vm/drop_caches -  page, dentries,inodes
    cat /proc/partitions    du -h ,  df -h
    cat /proc/devices   lsdev    welche Geräte angeschlossen
    free -lht   low-high-memory Range,human-readable,summenzeile
    df -h
    du -hd2 /    zeigt belegten speicher mit --max-depth 2 (gg-1,2,3,4...)
    ps
    pstree
    top
    atop
    htop
    netstat
    dokg -l             welche Software ist installiert
    dpkg -l | grep      <alle bekannten Frontends: openbox,xfce,gnome.kde ...>
    lsb_release -a      zeigt Distributiondinfo
    uname -a, -r. -v    all, Kernel Version, Distros Version
    sar | vmstat | sostat | nfsstat | cifsstat | dstat   -  live-Messung
Historische Auswertung:
 "   /var/log/*
    sar
    sadc
    sadf
    iostat -xc
    iostat -xd
    iostat -xp /dev/sda
    iostat -s 
    vmstat
    mpstat
    pidstat
    nfsiostat
    cifsiostat
Grafische Auswertungen:
    nagios
    sarface
    kSar
    collectd
    rrdtool
    CACTI
    MRTG
    MUNIN
    monit
-------------Kernel Modules
depmod              schreibt "lib/modules/$'(uname -r)'/modules.dep" Dependency of Kernel modules (.o, .ko)
insmod              Module laden Absoluter Pfad: "/../uname/kernel/drivers/usb/storage/usb-storage.ko
                    Abhängigkeiten geprüft aber nicht aufgelöst
lsmod               Status der Module abfragen "(/proc/modules)
rmmod usb-storage.ko       Module entfernen
modinfo  -a,-d,-l,-p,-n /../usb-storage.ko  (Author, Description, Licence, Parameter,Filename)           
modprobe            (insmode+rmmode) Löst Abhängigkeiten, keine Pfadangabe."
                    "/etc/modules.conf,modprobe,conf,modprobe.conf.local"- Steuerungdateien von modprobe
uname -r,-a,        /bin/uname - info über dem laufenden System
dmesg               auslesen von Kernel Ring Buffer. "/var/log/messages/ /var/log/syslog
less                erlaubt die gepacktre Logdateien direkt zu lesen
lspci               /sbin/lspci - liest PCI-Bus Systeme "/usr/share/nisc/pci.ids
lsudev              /usr/bin/lsdev "/proc/interrupts,ioports,dma
lsusb               
strace -c touch file    Kommandoanalyse
strings /usr/games/LS   liesst human-readable die binäre Dateien
ltrace              Komandoanylyse wie strace + laufende Signale die das Programm empfängt
lsof /mnt/nas       Geöffnete Dateien -list open files
lsof -i :22         lsof auf einem Port      
lsof | wc -l        wieviele geöffnete Dateien
fuser               ermittelt das Programm, das auf eine Datei zugreift
udev                verwaltet die Devices unterhalb /dev "/etc/udev/udev.conf /etc/udev/rules.d/
udevadm monitor     zeigt die Kernelereignisse bei der Bearbeitung von udev-rules
sysctl -w .conf.all.forwarding=1  Übergibt dem Kernel Parameter in die "/proc/sys, /etc/systcl.d
    echo 1 > /proc/sys/net/ipv6/conf/all/forwarding  (das gleiche ohne sysctl)
