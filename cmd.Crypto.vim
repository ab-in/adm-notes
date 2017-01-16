Verschlüsselung von Daten
Secure Shell Dämon

SSH ist aus der Unzufriedenheit der User mti telnet entstanden. SSH ist demnach auch der direkte Nachfolger von telnet, hat aber die Schwachstellen - die telnet in verruf brachten - ausgemerzt.

Die Übertragung von Daten mittels SSH erfolgen immer Verschlüsselt, wobei auch die Authentifizierung am Server erfolgt. Dies kann entweder mittels Passwort oder / und Zertifikat erfolgen. Anschließend verschlüsselt SSH den Datentunnel, so dass ein großes maß an Sicherheit gewährleistet wird.

Ebenfalls eine nette Zusatzfunktion ist die Übertragung der X-Window-Programmfester.

SSH verwendet zur Datenübertragung per default den Port 22.

Mittlerweile ist die Version 2 von SSH im Einsatz, wobei die beiden Versionen nicht direkt miteinander kompatibel sind.

Installation des SSH-Servers

DEB:    apt-get install openssh-server
RHEL: yum install openssh-server.i686 [oder amd64 Version!]

Im Zweifelsfall nach einem alternativen Server suchen: 

apt-cache search secure shell server

HINWEIS: Bei den meisten Distributionen wird per Default der ssh-client mit installiert. Dieser ist auf einem ssh-server nicht zwingend erforderlich, jedoch empfohlen, da in diesem Paket der SecureCoPy zur Datenübertragung enthalten ist!

Installation mittels 

DEB:    apt-get install openssh-client 
RHEL:   yum install openssh-clients.i686 (oder amd64)

Nachdem der SSH-Server installiert wurde, wird ein RSA-Default-Schlüssel und ein DSA-Default-Schlüssel erzeugt! Diese sind für die Basis-Verschlüsselung erforderlich und befinden sich im Default-Verzeichnis /etc/ssh! Erst danach ist es möglich, den Server zu starten!

HINWEIS: Würde nicht mindestens ein RSA- & DSA-Schlüssel generiert werden, könnte man auch auf ssh verzichten und bei telnet bleiben, da keine Verschlüsselung möglich wäre! Der Server ist jedoch so programmiert, dass er diese zwei Dateien voraussetzt! Diesen Hintergrund sollte man für eine evtl. Fehlersuche kennen!
Protokoll-Versionen

Den SSH - Dienst gibt es aktuell in zwei Protokollversionen.
Wichtig ist, dass die beiden Versionen NICHT KOMPATIBEL zueinander sind, da die Version 2 keine Weiterentwicklung der Version 1 ist, sondern eine komplette Neuimplementation ist.
Ein Server, der nur Version 2 annimmt, kann mit keinem Client kommunizieren, der nur Protokoll 1 beherrscht!
Die Konfigurationsdateien

serverseitig ist die Konfigurationsdatei die /etc/ssh/sshd_config

clientseitig ist die Konfigurationsdatei die /etc/ssh/ssh_config

clientseitige private Konfigurationsdatei $HOME/.ssh/config

Hostkeys        /etc/ssh/known_hosts
$HOME/.ssh/known_hosts
(auch Fingerabdrücke oder fingerprints genannt)

eigene Schlüsselsammlung
$HOME/.ssh/authorized_keys

Ist SSH installiert, so sind i.d.R. beide Komponenten installiert    und sollten beide konfiguriert werden.

/etc/ssh/known_hosts    in dieser Datei werden die systemweiten                    fingerprints der Rechner abgelegt, die                  sich bereits mit dem System verbunden                     haben, bzw. ihren öffentlichen Schlüssel                    dem Server zukommen lassen haben.

$HOME/.ssh/known_hosts  wie oben, jedoch bezogen auf einen                       einzelnen Benutzer
Die Serverkonfiguration
/etc/ssh/sshd_config

Port 22         Welcher Port wird verwendet? (Default 22)

Protocol 2[,1]      Welche Version wird verwendet? Damit auch                Version 1 mit unterstützt wird, muss der                Eintrag von 2 auf 2,1 geändert werden.              Die Reihenfolge spielt dabei auch eine              Rolle!

ListenAddress ::1        Wird IPv6 verwendet, so ist der Eintrag                     der ULA zwingend notwendig! 

ListenAddress 192.168.2.55
Legt fest, auf welcher IP der SSH-Dämon              lauschen soll. 

Wird derWert nicht angegeben, so lauscht der SSH-Dämon an allen vorhandenen IP-Adressen - Ressourcenverbrauch beachten! Jede NIC erzeugt min. 1 Instanz des Servers!

LogLevel INFO        Legt den Protokollierungsgrasd fest

PermitRootLogin yes  IMMER AUF NO SETZEN!!!
Legt fest, ob sich der Client am Server     mit dem root-Konto anmelden darf oder   nicht. Wenn diese Variable auf no steht,    dann ist es aber trotzdem möglich - nach   einer Anmeldung als normaler Benutzer -     mittels su root-Rechte zu erlangen!

X11Forwarding yes       Erlaubt oder sperrt die Weiterleitung der               grafischen Ausgabe auf den Client. Wenn                 beim Verbindungsaufbau der Schalter -X               verwendet wird
PrintLastLog yes
Soll nach der Anmeldung der Zeitpunkt des               letzten Logins mit diesem Benutzernamen                 angezeigt werden?

Erzeugt bei jedem Login folgende Ausgabe:

Last login: Thu Feb  6 07:25:31 2014 from   192.168.2.106

Damit kann nachvollzogen werden, wer und    wann sich auf  dem Server angemeldet hat,   oder ob u.U. der genutzte Account gehackt   wurde

AllowUsers <username>[, <username>...]
Erlaubt den Login nur für den / die                 angegebene(n) Benutzer - alle anderen               Benutzer werden dadurch abgelehnt.

PasswordAuthentication yes
Verbindung mit einem Passwort zulassen              oder abweisen.

Steht hier no, dann ist eine Verbindung lediglich mittels Authentifizierungs-schlüssel möglich, der vorher natürlich ausgetauscht und eingefügt wurde! Werden mehrere Schlüssel von mehreren Benutzern abgelegt, so werden diese einfach nur an das Ende der Datei angefügt.

Die Clientkonfiguration

/etc/ssh/ssh_config

ForwardX11 no
ForwardX11Trusted yes   Dienen der Freigabe der GUI-Übertragung                   unter X.

Der zweite Eintrag erlaubt ausschließlich Benutzern, die sich mittels DSA-Schlüsseldatei UND gesetzter Passphrase Authentifizieren die Bildschirm-übertragung

IdentityFile ~/.ssh/identity
IdentityFile ~/.ssh/id_rsa
IdentityFile ~/.ssh/id_dsa

Lage der privaten Schlüsseldateien
Hier sollte man die Standard-Schlüsseldatei-Einträge NICHT ÜBERSCHREIBEN, sondern einfach um einen weiteren IdentityFile-Eintrag erweitern!

Port 22         Portangabe des Clients, falls abweichend
Protocol 2,1        Protokollauswahl
Reihenfolge der Versionen ist zu                    beachten! bei 2,1 wird erst 
die Version 2 verwendet. Schlägt diese fehl, wird dann erst auf Version 1 umgeschaltet. Eine Angabe in Form 1,2 ist ebenfalls möglich!

HashKnownHosts yes  sollen die erstmalig übertragenen                    Schlüssel sofort gespeichert werden?
(Abfrage bei der erstmaligen Verbindung, ob der Fingerabdruck gespeichert werden soll. Erhöht die Sicherheit!)

SendEnv LANG LC_*       Überträgt die Umgebungs- und Sprachein-                   stellungen – also Inhalte der LANG und                  alle LC_ - Variablen ) an den Server.                   Dies hilft bei einer Verbindung zu                      Servern, die in einer abweichenden                    Sprache aufgesetzt sind.

Die automatische Konfiguration

Wenn eine Verbindung zu einem oder mehreren Hosts mit  unterschiedlicher Konfiguration immer wieder hergestellt werden     muss, kann man die Übergabewerte für das SSH-Kommando in einer  Datei abspeichern.

Der Vorteil dieser Datei ergibt sich auch daraus, dass man -  unabhängig der globalen Einstellung in der ssh_config,  abweichende Optionen für diese eine Verbindung verwenden kann. Es   können natürlich auch mehrere Host´s in dieser Datei angelegt   werden. Dazu muss lediglich zwischen den Konfigurationen eine   Leerzeile gelassen werden und wieder mit dem Schlüsselwort “Host”   begonnen werden.

Die Datei liegt dabei im Home-Verzeichnis/.ssh/

$HOME/.ssh/config

Beispiel

Host its
Hostname 192.168.2.108
User vm
Port 22
ForwardX11Trusted yes
TCPKeepAlive yes
IdentityFile ~/.ssh/private_dsa-key-file
Cipher blowfish

ssh -l vm 192.168.2.108 -p 22 -o ForwardX11Trusted yes,         TCPKeepAlive yes,IdentityFile ~/.ssh/private_dsa-key-file,      Cipher blowfish

Alle Einstellungen, die hier abweichend von der Default     Konfiguration in der /etc/ssh/ssh_config angegeben werden,  überschreiben die Default-Werte!

Es können mehrere Host - Einträge in der Datei angelegt werden! Dabei bitte unbedingt die korrekte Syntax beachten!

Nach der “Überschrift” also Host die Folgezeilen einrücken
KEINE Leerzeilen innerhalb einer Host-Konfiguration
Werte und Einstellungen in der config haben Priorität!
Es kann auch eine abweichende spezielle Schlüsseldatei angegeben und verwendet werden!

Um mit diesem Host eine Verbindung aufzubauen, ist es nur   notwendig, den in der Zeile Host angegebenen Verbindungsnamen   anzugeben.

ssh its

Wie üblich muss nach einer Änderung an der Server-  Konfigurationsdatei der SSH-Server neu gestartet werden, damit    die Änderungen übernommen werden!

Den SSH-Server starten

/etc/init.d/ssh[d] start

oder

service ssh[d] start

Eine Verbindung aufbauen

Syntax

ssh [ Schalter ] [user@]<Zielhostname oder IP> [ Kommando ]

Auf die Angabe eines Benutzernamens kann verzichtet werden, wenn   der Benutzername auf dem Server und dem Client identisch sind.  Wird kein Benutzername angegeben so nimmt ssh den aktuell     angemeldeten Benutzernamen und versucht die Anmeldung mit genau     diesem Namen!

Schalter

-l <user>   am Zielsystem mit dem angegebenen usernamen              anmelden

alternative username@hostname
Wird kein Benutzername beim Verbindungsaufbau                angegeben, so wird versucht, eine Anmeldung mit                 dem - auf dem Client - aktiven Benutzernamen              vorzunehmen. Schlägt natürlich fehl, wenn es                auf dem Server den Benutzer nicht gibt!
-X      X-Window.Fensterübertragung aktivieren
Alle Programme, deren Ausgabe auf einer GUI                 erfolgen, werden auf den Client übertragen. Der                 Prozess läuft auf dem Server, die Ausgabe               erfolgt am Client.
-1      Protokoll Version 1 erzwingen
-2      Protokoll Version 2 erzwingen
Ergibt bei ungleichen Protokollversionen einen              Fehler:
Protocol major versions differ: 1 vs. 2
-D<IP:Port> Die Verbindung mit der angegebenen IP und dem               Port aufbauen - falls im System mehrere IPs im              Einsatz sind
-F <Datei>  Zur Verbindung eine alternative Client-                 Konfigurationsdatei als die /etc/ssh/ssh_config                 verwendet
-i <Datei>  Verwenden einer anderen Identität, als die, die                 in der $HOME/.ssh/identity angegeben Identität
-L <[IP:]lokalPort:remoteIP:remotePort>
ssh meldet sich nicht direkt an, sondern baut                eine Tunnelverbindung über einen vorgegebenen               Port mit dem Ziel auf. Ruft man auf dem lokalen              Rechner die Adresse localhost:localport auf, so                 wird man per SSH-Tunnel auf den Remote-Host mit               dem angegebenen Remote-Port weitergeleitet.
-R <[lokaleIP:]:lokalPort:remoteIP:remotePort>
identisch mit dem Schalter -L. Nur wird der                 Tunnel in umgekehrter Richtung aufgebaut. Also              vom remote zum lokalen Rechner.
-o <Option[en]>
für diese eine Verbindung eine oder mehrere                 abweichende Option(en) angeben. Es sind alle                Optionen möglich, die in der                             /etc/ssh/ssh_config auch verwendet werden. Die              hier angegebenen Einstellungen überschreiben               dann temporär den in der Konfigurationsdatei                gespeicherten Wert.
-p <Port>   für diese Verbindung den angegebenen Port               verwenden - zu beachten ist hier, dass die              Verwendung der priviligierten Ports nur dem                 root verbehalten sind! Baut ein normaler User               eine Verbindung mit einer abweichenden                     Portangabe auf, so muss ein Port >= 1024                    gewählt werden. Dies ist auch bei der SSH-             Serverkonfiguration zu bedenken!
alternativ: 192.168.x.x:<Port>
-q      Meldungen (Warnhinweise oder diagnostische 
Informationen) bei der Verbindung unterdrücken
-y      Ausgabe der Fehlermeldungen und Hinweise in die                 Syslog, anstelle auf STDERR

Das Zielverzeichnis dauerhaft in das lokale Dateisystem mit     einbinden

Vergleichbar mit einem mount eines Verzeichnisses wie bei NFS   oder Samba, ist es auch mittels SSH möglich eine entfernte  Verzeichnisstruktur auf den lokalen Rechner zu mounten.

Dazu gibt es ein Paket mit dem Namen

sshfs

welches sich einfach mittels eines Paketmanagers installieren   lässt. Die Verbindung wird intern über einen SSH-Tunnel  aufgebaut, der permanent aktualisiert wird.

sshfs ist kein Bestandteil der LPI-Objectives!
HINWEIS zu /etc/nologin
Die LPI nennt im Zusammenhang mit der Unterbindung einer SSH-   Verbindung die Datei /etc/nologin. Wie bekannt sollte dies  allerdings in der Praxis nicht angewandt werden, da nach dem    Erstellen dieser Datei ausser einer Remote-Anmeldung auch eine     lokale Anmeldung nicht mehr möglich ist - ausgenommen natürlich  root! Es ist in der Praxis sinnvoller den SSH-Dämon einfach zu  stoppen, um Verbindungen zu unterbinden und bei Bedarf wieder zu   starten!

In der Prüfung ist dieses verfahren allerdings nicht gefragt. Bei   einer entsprechenden Fragestellung erwartet die LPI die Angabe  der /etc/nologin!

/etc/sshrc

Diese Datei entspricht technisch gesehen der lokalen .bashrc,     wird jedoch nach erfolgter Anmeldung auf dem Remote-System  ausgeführt. Darin können z.B. Aliase oder Links etc. eingetragen  werden.

/etc/hosts.allow & /etc/hosts.deny

Bei der Zugriffssteuerung in SSH kommt auch die Datei hosts.allow     und die hosts.deny zum Einsatz. Möchte man bspw. nur eine SSH-  Verbindung aus dem lokalen Netz zulassen, so muss dies in diesen  Dateien hinterlegt werden.

Ansonsten gelten für diese beiden Dateien die bekannten     Vorrangsregeln.

Alternativ ist auch eine Verwaltung über die sshd_config mit  AllowUsers möglich! Unterschied: in der hosts.* können Sie  komplette IP-Ranges oder einzelne IPs verwalten, in der     sshd_config nur Benutzer über deren Benutzernamen.

$HOME/.ssh/authorized_keys

In dieser Datei werden die öffentlichen Schlüssel des Remote-    Systems abgelegt, mit denen dieser User bereits verbunden war und   sich mittels Schlüssel authentifiziert hat.
Die Schlüssel für SSH – klassischer Weg

Die Authentifizierung erfolgt bei SSH entweder über ein Passwort     oder mittels einer Schlüsseldatei (auf Wunsch auch in Verbindung    mit einem Passwort).

Man kann den Server natürlich auch so einstellen, dass die    Authorisierung ausschließlich mittels Schlüssel vorgenommen     werden darf.

Die Schlüssel und deren Erstellung

Es werden bei einer Schlüsselgenerierung immer Schlüsselpaare   erzeugt. Ein öffentlicher Schlüssel und ein privater Schlüssel,     der den öffentlichen Schlüssel ebenfalls mit beinhaltet!

Bei den Schlüsseldateien handelt es sich um reguläre ASCII- Textdateien, die mit jedem Editor oder Pager angezeigt werden   können. Notfalls kann man diese Schlüssel auch ausdrucken und in  Papierform als Backup speichern!
Ein Schlüsselpaar erstellen

ssh-keygen [ -t dsa | rsa ]

Es wird per Default ein DSA-Schlüsselpaar erstellt. Der     Schlüsseltyp selbst kann explizit mit dem Schalter -t angegeben     werden.

Dabei dient ein DSA-Schlüssel zur Authentifizierung und ist einer   Signatur gleich zu stellen und der RSA-Schlüssel dient dazu, die     Verbindung selbst zu verschlüsseln!

Nach der Ausführung des Kommandos wird nach dem Speicherort für     die Schlüsseldateien gefragt. Dabei spielt es keine Rolle,    welchen Ordner Sie angeben. Die Datei kann anschließend auch ein    das entsprechende Verzeichnis kopiert werden.

Bei einem DSA-Schlüssel werden die Dateien id_dsa und id_dsa.pub    generiert, die per default in $HOME/.ssh/ abgelegt werden  sollten.

Weiter wird auch noch eine Passphrase abgefragt, also zu diesem     Schlüssel selbst noch eine weitere Sicherheit in Form eines  Passworts. Das Passwort bei der Verbindung ist dann abweichend  vom Benutzerpasswort!

HINWEIS: Es muss nicht zwangsläufig für jeden Client ein eigener    Schlüssel erstellt werden, wenn mehrere Clients sich mit dem     Server verbinden sollen! Alle können auch den identischen   Schlüssel (auch Sammelschlüssel genannt) verwenden, wobei eine     Mehrfach-Anmeldung Problemlos möglich ist.

Man hat jedoch dabei den Nachteil, dass man nicht genau     Nachvollziehen kann, wer für einen Fehler oder einen Incedent  verantwortlich ist!

Anschließend (kann bei Bedarf einer expliziten  Verbindungs-    verschlüsselung) auch noch ein RSA-Schlüssel erzeugt    werden!

Die öffentlichen Schlüssel (DSA ggf. noch den RSA) müssen nun   auf den Server übertragen und dort in die    

/etc/ssh/authorized_keys 

oder in die 

$HOME/.ssh/authorized_keys hinzugefügt werden.

Dabei werden in der Datei /etc/ssh/authorized_keys die Schlüssel    abgelegt, die auf Host-basierter Authentifizierung erfolgen und   in der ~/.ssh/authorized_keys die benutzerbasierten     Authentifizierungen!

Die Datei kann auch umbenannt werden! Dann muss die Datei in der    Konfigurationsdatei von ssh bekannt gegeben werden!

Die Erstellung der Schlüssel erfolgen i.d.R. immer auf dem Client    und werden dann mittels Secure Copy auf den Server übertragen!

Dazu eignet sich idealerweise das Kopieren der Datei mittels SCP. 

Vorgang


# scp [ -P port ] <RSA & DSA-pub-keys> user@remote:/Ziel-Ordner


Wird SSH auf einem von 22 abweichenden Port betrieben, so muss dieser mit dem Schalter -P angegeben werden. Dabei ist zu beachten, dass der Schalter am Ende NICHT funktioniert! Er muss vor der Benutzeranmeldung (also vor dem Anmeldenamen) angegeben werden!

SSH-Verbindung zu dem Remote aufbauen

# cat <DSA-Schlüssel> >> $HOME/.ssh/authorized_keys

Anschließend kann eine Verbindung ohne die Angabe eines Kennworts   erfolgen!

Link: http://www.schlittermann.de/doc/ssh.html
Der SSH- Authentifizierungs-Agent

Der SSH-Agent dient der automatischen Anmeldung per SSH an einem  Remote.

Der Vorteil liegt darin, dass beim Verbindungsaufbau kein Passwort mehr eingegeben werden muss, da diese in Form von Fingerabdrücken im SSH-Agent gespeichert werden.

Dabei ist es auch durchaus möglich, dem SSH-Agent mehrere Schlüssel und Passwörter, also Fingerabdrücke mitzuteilen.

Kommandos

Verwaltung des SSH-Agents    

# ssh-agent <Schalter>

Schalter

-x  sperrt den ssh-agent
-X  entsperrt den ssh-agent ( mittels dem - beim                Sperrvorgang
hinterlegten - Paswort )
-d <key>
löscht den angegebenen Fingerabdruck
-D  entfernt alle Fingerabdrücke aus dem ssh-agent
[-s]    liest den Schlüssel aus einer SmartCard
[-e]    entfernt den Schlüssel der SmartCard

Einen Schlüssel dem SSH-Agent hinzufügen

# ssh-add <Schlüsseldatei>

HINWEIS: Der Schlüssel wird per Default bereits dem ssh-agent   übergeben Abfrage mit ssh-add -l, Löschen eines Schlüssels mit   ssh-add -d, Löschen aller gespeicherten Schlüssel mit ssh-add -D. 

OpenSSH im Überblick
Installation SSH-Server
DEB:    # apt-get install openssh-server
RHEL: # yum install openssh-server
DEB:    # apt-get install openssh-client
RHEL:   # yum install openssh-clients
Die SSH-Familie
ssh     ein Secure-Shell-Client als Ersatz für telnet, rlogin und         rsh
scp     Secure Copy, ersetzt rcp
sftp    Secure FTP
Bestandteile von OpenSSH
Wichtige Befehle
sshd            der SSH-Daemon
ssh-keygen      erzeugt Authentifizierungsschlüssel
ssh-keyscan     liest öffentliche Schlüssel ein
ssh-agent       speichert den privaten Schlüssel im                  Arbeitsspeicher
ssh-add     lädt weitere private Schlüssel in den                   ssh-agent
ssh-copy-id     kopiert die Identität (Public Key) auf den                 Server
Wichtige Dateien
/etc/ssh/sshd_config    # Konfigurationsdatei des OpenSSH-Servers
/etc/ssh/ssh_config     # Konfigurationsdatei des OpenSSH-Clients
~/.ssh/config     # Datei für die automatische Anmeldung
~/.ssh/authorisized_keys
# Datei für die Schlüssel – serverseitig
~/.ssh/known_hosts  # Hostkeys bekannter Server
/etc/ssh/ssh_known_hosts
# Admin kann hier vertrauenswürdige 
Server hinterlegen
Server-Konfiguration /etc/ssh/sshd_config
Port          In der Regel auf 22 (Standard SSH-Port) gesetzt, sind            alternative Angaben oder ZUSÄTZLICHE Ports möglich)
Alternative: 2222 (umgeht das root-Port-Problem)
besser zusätzlich, allerdings ebenfalls ein                 Sicherheitsrisiko:
Port 22 2222
Protocol 2[,1]  Setzen des verwendeten Protokolls - Protokoll 1 ,          Protokoll 2 oder beide 2,1 (1 nur aus                   Kompatibilitätsgründen zu älteren Systemen)
PermitRootLogin yes | no
root wird als Username akzeptiert wenn gesetzt                (sicherheisrelevant: auf no setzen, weil dann User          und PW bekannt sein müssen)
PasswordAuthentication yes | no
erlaubt die Anmeldung per Passwort wenn gesetzt,            sollte Schlüsselauthentifizierung gesetzt sein, kann            dieser Zugang auch auf “no” gesetzt werden.
HINWEIS: Wunderbare Möglichkeit, sich auszusperren!             Schlüsselautentifizierung TESTEN, bevor man dies so             konfiguriert – 2. EINGELOGGTER Terminal, damit im            Notfall noch Änderungen vorgenommen werden können)
PubkeyAuthentication yes | no
erlaubt die Anmeldung per Public Key wenn gesetzt
PermitEmptyPasswords yes | no   
erlaubt die Anmeldung ohne Passwort wenn gesetzt            (never ever!)
ListenAddress   Server lauscht nur auf der NIC mit der gesetzten IP-            Adresse, ansonsten würde er auf jeder IP jeder NIC            lauschen, die verbaut ist (> Serverinstanzen).              Außerdem ist hier die Angabe eines Ports möglich:
Listen 192.168.0.25:80
SSH lauscht hier dann also auch auf Port 80.        
MaxAuthTries    die Anzahl der Einlogversuche, die schiefgehen dürfen           - nach Anzahl / 2 + 1 werden diese Ereignisse geloggt
MaxStartups     limitiert die Anzahl der unauthentifzierten                 Verbindungen
StrictHostKeyChecking yes | no |ask
meldet veränderte Schlüssel wenn gesetzt
X11Forwarding yes | no
erlaubt / verbietet Zugriff auf remote X
http://www.thelinuxguy.nl/ssh-ftp-server/how-to-secure-ssh-in-linux/
Public Key in ~/.ssh/authorized_keys auf dem Zielsystem eintragen (siehe auch ssh-copy-id, Bsp- unten)
Konfigurationsoptionen - nicht LPI-relevant LPI 102, aber in LPI 201!
Allow/DenyUsers erlaubt/verbietet den mit Leerzeichen aufgeführten             Usern die Nutzung von SSH 
Allow/DenyGroups    erlaubt/verbietet den mit Leerzeichen aufgeführten             Gruppen die Nutzung von SSH
HINWEIS: Man kann beide Optionen auch in Zusammenhang             mit IP-Adressen verwenden:
AllowUsers: bigmama@192.168.0.128 (?/* funktionieren)
AllowUsers: bigmama@192.168.0.0/24
Host            erlaubt den mit Leerzeichen aufgeführten Hosts die           Nutzung von SSH – das kann eine IP(-Range) oder             Netzmaske (CIDR) sein, oder ein FQDN:
www???@arbeitstier.local
Tipps & Tricks
# ssh -Xf host xterm
öffnet ein XTerminal dass auf der eigenen Maschine          angezeigt wird, aber auf der anderen (> Server) läuft
# scp [ -P port ] <RSA & DSA-pub-keys> user@remote:/Ziel-Ordner
sicheres, weil verschlüsseltes, Kopieren von Dateien -      ähnlich wie "rsync".
Beispiel Schlüsselpaar erzeugen und verteilen
# cd ~/.ssh
# nano config
# chmod 640 config
# umask 022
# ssh-keygen -t dsa
# scp id_dsa.pub 10.6.131.190:~/.ssh/new000_authorized_keys
# ssh 10.6.131.190
Remote Rechner
# cat ~/.ssh/new000_authorized_keys >> \                   ~/.ssh/authorized_keys
# chmod 600 authorized_keys
# rm new000_authorized_keys
Anmeldung mit Schlüsselpaaren – der direkte Weg mit ssh-copy-id
Auf dem Client
$ ssh-keygen
Hier kann man die Voreinstellungen übernehmen oder sich anders  entscheiden - aus den man-Pages von ssh-keygen:
-b bits (optionale Angabe)
Specifies the number of bits in the key to create.  For RSA keys,     the minimum size is 768 bits and the default is 2048    bits.   Generally, 2048 bits is considered sufficient. DSA keys must be    exactly 1024 bits as specified by FIPS 186-2. For ECDSA keys,   the -b flag determines the key length by selecting from one     of three elliptic curve sizes: 256, 384 or 521 bits. Attempting     to use bit lengths other than these three values for ECDSA keys     will fail.
- t type (optionale Angebe)
Specifies the type of key to create.  The possible values are   “rsa1” for protocol version 1 and “dsa”, “ecdsa”, “ed25519”, or     “rsa” for protocol version 2.
Die Maximalgröße ist eigentlich nicht begrenzt, es sollte aber  betrachtet werden, das längere Schlüssel auch längere   Generierungszeit bedeuten. 4096 Bit-Schlüssel ist schon eine   extrem sichere Wahl.
Nun wird der Public Key auf das Konto des Zielrechners kopiert,     das zur Anmeldung verwendet werden soll:
$ ssh-copy-id -i ~/.ssh/id_rsa.pub \
<username>@<IP | Name Zielrechner>
Anmeldung am Zielrechner - sollte eine Passphrase für den Key   eingetragen worden sein, wird diese nun abgefragt. Ist keine   Passphrase gewählt worden, funktioniert das Login nun ohne  Passworteingabe.
$ ssh <username>@<IP | Name Zielrechner>
Mit exit verlässt man die Serveranmeldung. Auch die Abfrage der     Passphrase kann man sich erleichtern - mit dem ssh-agent - ein  Dienst, der die Passphrases auf dem Client verwaltet - Zufügen  der Passphrases (für alle vorhandenen, nicht erfassten)   Schlüssel: 
$  ssh-add
Es folgt die Abfrage nach der / den Passphrase(s). Sind diese   richtig eigegeben kann man sich nun ohne Eingabe des Passworts     einloggen:
$  ssh <username>@<IP | Name Zielrechner>
Troubleshooting ssh-add - ID wird nicht akzeptiert
$ eval $(ssh-agent)
$ ssh-add /home/<user>/.ssh/id_rsa  # Pfad zum Key
$ ssh <username>@<IP | Name Zielrechner>
HINWEIS: Um eine Namensauflösung ohne internen DNS-Server   hinzubekommen, muss lediglich eine Zeile für jeden Rechener in     der Form
IP-Adresse  Hostname(n) 
in die /etc/hosts eingetragen werden!
Aufräumen mit
$ ssh-agent -k
Eliminiert die Session Keys in /tmp.
Troubleshooting SSH
Der Dämon SSH kann mit den Flags -v(vv) oder -d(dddd) aufgerufen   werden um aussagekräftige Fehleranalyse betreiben zu können.    Interessanter ist dabei das debug (-d)-Flag, weil es eine  Schritf-für-Schritt-Analyse auf der Konsole ermöglicht.
Testking-Fragen zu SSH Version LPI 3.5/4.0
http://www.aiotestking.com/linux/which-parameter-in-sshd_config-will-allow-the-administrator-to-systematically-provide-access-to-certain-user-accounts-by-name/
http://www.aiotestking.com/linux/where-is-the-global-list-of-known-ssh-host-keys-located-3/
http://www.aiotestking.com/linux/what-will-happen-when-users-try-to-connect-with-ssh-3/
http://www.aiotestking.com/linux/the-file-etcssh_host_key-should-be/
http://www.aiotestking.com/linux/the-file-etcssh_known_hosts-typically-contains-hosts-keys-for-3/
http://www.aiotestking.com/linux/what-command-do-you-use-to-generate-an-openssh-host-key/
http://www.aiotestking.com/linux/which-configuration-file-would-you-edit-to-change-default-options-for-outbound-ssh-sessions-3/
http://www.aiotestking.com/linux/what-command-is-used-to-hold-keys-during-a-login-session-to-be-used-for-automatic-authentication-while-logging-in-to-other-machines-using-ssh/
http://www.aiotestking.com/linux/which-two-of-the-following-lines-found-in-an-ssh-configuration-file-2/

Der Gnu Privacy Guard (GPG) - Grundlagen
Link: http://de.wikipedia.org/wiki/OpenPGP
Link: http://de.wikipedia.org/wiki/GNU_Privacy_Guard
Link: http://de.wikibooks.org/wiki/GnuPG
Link: http://www.online-tutorials.net/security/gnupg-gpg-tutorial/tutorials-t-69-124.html
Verschlüsselungsvorgang

Es wird ein Schlüssel-Triple erstellt

privater | öffentlicher | wiederrufs-Schlüssel

Schlüssel für den produktiven Einsatz, bei dem es um absolute Sicherheit geht und bei Anwendungsgebieten, bei den die Identität zweifellos bestätigt werden muss, sollte dieser Schlüssel von einer öffentlichen Zertifizierungsstelle ausgestellt werden.

Für kleinere Unternehmen und Privatpersonen kann man unter Linux problemlos seine eigenen Schlüssel generieren. Es gibt auch diverse Internetseiten, bei denen man einen offiziellen Schlüssel für E-Mails kostenlos erhält!

Kostenloses E-Mail-Zertifikat von Commodo  http://www.comodo.com/home/email-security/free-email-certificate.php

Ablauf eines verschlüsselten Mailversands

1)  Absender fordert den öffentlichen Schlüssel des             Empfängers an 
2)  Absender verschlüsselt die eMail mit dem öffentlichen           Schlüssel des Empfängers
3)  Mail wird verschlüsselt an den Empfänger gesendet
4)  Empfänger entschlüsselt die Mail mit seinem privaten     Schlüssel und kann diese nun in Klartext betrachten

Schlüssel in Linux selbst erstellen

gpg --gen-key
Schlüsselart auswählen (DSA und Elgamal)
Schlüssellänge auswählen
Gültigkeit des Schlüssels festlegen
Persönliche Daten angeben
ein zusätzliches Kennwort (Passphrase) angeben

Das Schlüsselpaar wird nun generiert und im Homeverzeichnis des aufrufenden Benutzers abgelegt

~/.gnupg
secring.gpg # privater Schlüssel
pubring.gpg # öffentlicher Schlüssel

Widerrufszertifikat erstellen

gpg --gen-revoke <Benutzername> # alle Fragen beantworten

HINWEIS: In eine Datei umleiten, kopieren bringt ggf.       Zeichen in die Datei, die den Schlüssel unbrauchbar machen.

Das Widerrufszertifikat gut und sicher aufbewahren ( am         besten 1x Ausdrucken und 1x auf einen externen Datenträger,         welcher gut gegen unbefugten Zugriff geschützt sein             sollte) aufbewahren! 

Link: http://wiki.ubuntuusers.de/GnuPG/Web_of_Trust

Zertifikat widerrufen

gpg --import <widerrufsschlüsseldatei>

Eine Datei verschlüsseln

gpg --encrypt <Datei>

Eine Datei entschlüsseln

gpg --decrypt <verschlüsselte Datei>

Einen vorhandenen Schlüssel modifizieren

gpg --edit-key <key>

Bei E-Mails wird die Ver- und Entschlüsselung i.d.R. durch den  MUA vorgenommen!
Links:
https://www.gnupg.org/
https://www.gnupg.org/documentation/
http://wiki.ubuntuusers.de/GnuPG
http://wiki.kairaven.de/open/krypto/gpg/gpganleitung

Fragen zu GnuPG – LPI Version 3.5 (zzt. Keine Fragen in der 4.0)
http://www.aiotestking.com/linux/when-attempting-to-send-a-file-to-another-user-securely-with-gpg-which-of-the-following-actions-must-be-done/
http://www.aiotestking.com/linux/what-command-would-be-used-to-check-the-gpgp-signature-on-a-downloaded-source-file-3/
http://www.aiotestking.com/linux/which-option-when-passed-to-the-gpg-command-will-enter-an-interactive-menu-enabling-the-user-to-perform-key-management-related-tasks-3/
http://www.aiotestking.com/linux/which-directory-in-a-users-home-contains-configuration-files-and-key-rings-for-gpg-3/
http://www.aiotestking.com/linux/when-attempting-to-send-a-file-to-another-user-securely-with-gpg-which-of-the-following-actions-must-be-done/


