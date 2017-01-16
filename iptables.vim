Verein für Informationstechnologie
www.it-academy.cc - Artikelausdruck

Firewall mit iptables - Eine Einführung in die iptables (linux 2.4) firewall. 
Wohl die schnellste Möglichkeit sich eine kleine Firewall zu bauen.

Autor:  Franz Schaefer
Datum:  22-03-2002, 16:57:14
Schwierigkeit:  Anfänger
Referenzen: man iptables
http://people.unix-fu.org/andreasson/iptables-tutorial/iptables-tutorial.html
http://netfilter.samba.org/unreliable-guides/NAT-HOWTO/NAT-HOWTO.linuxdoc.html
http://www.linuxguruz.org/iptables/howto/iptables-HOWTO.html
Rating-Punkte:  4

Übersicht
-------------------
heute wollen wir selbst eine kleine packet-filter firewall basteln. zum
filtern von IP packeten haben die verschiedenen unixe unterschiedliche
befehle und interne filter strukturen. linux 2.0 hatte ipfwadm linux 2.2
hatte ipchains und linux 2.4 hat iptables. bei freebsd gibt es ipf
(ipfilter). etc...

wir wollen uns erstmal auf linux 2.4 iptables beschraenken.

iptables -L -n

zeigt uns an welche bestehenden iptables filter regelen auf unseren system
definiert sind. bzw finden wir mit dem befehl heraus ob unser kernel
ueberhaupt mit unterstueztung fuer iptables ausgestattet ist. falls nicht
muessen wir uns einen neuen kernel zulegen. (ipchains ist dem iptables
relativ aehnlich viele der hier genannten dinge kann man in aehnlicher
weise auch mit ipchains realisieren.. falls man das will: die details in
der manpage nachlesen)

sind noch keine regeln installierst so ist besteht die ausgabe aus:

Chain INPUT (policy ACCEPT)

Chain FORWARD (policy ACCEPT)

Chain OUTPUT (policy ACCEPT)

in diese 3 "chains" koennen wir filter reglen einpacken. in die "chain"
INPUT gehoeren alle filteregeln die eingehende packete filtern sollen. 
analog OUTPUT fuer ausgehende packte und FORWARD fuer packete die von
einem interface zum anderen durchgeroutet werden sollen.

angenommen wir wollen alle zugriffe von aussen auf das printer port ( TCP
port 515) filtern:

iptables -A INPUT -p tcp --dport 515 -j DROP

das -A bedeutet "append" und fuegt die regel an die INPUT queue am ende
an. (-I waere insert und weurde die regel am anfang der queue eintragen. 
die queue wird fuer jedes packte von anfang an bearbeitet. packte die
vorne stehen haben daher prioritaet vor welchen die am ende stehen)

-j DROP ist das sogenannte "target" und besagt was mit dem packet
geschehen soll. in diesem falle: DROP verwirft das packet. (REJECT weuerde
einen zugriff auf das port explizit mit einer antwort ablehnen. DROP ist
insoweit besser als es einen moeglichen angreifer im ungewissen laesst was
jetzt eigentlich mit seinem packet los ist...)

ACCEPT wuerde das packet akzeptieren. es werden dann keine weiteren regen
mehr durchlaufen. weiters kann man als target auch den namen einer selbst
definierten chain angeben die das packet dann weiter behandelt. so kann
man packte hirarchisch strukturiert bearbeiten und auch die performance
erhoehen weil nicht mehr alle packte sequentiell abgebreuft werden muessen
sondern man mit vorentscheidungen die genaue behandlung der packete in
mehrer subchains aufspalten kann.

packte die geforwarded werden bei ipatables NICHT durch die INPUT und
OUTPUT chain geleitet sondern nur durch die FORWARD (bei ipchains war das
anders). in welche chain ein packet hier kommt wird nach der routing
entscheidung festgelegt.



zum umschreiben von packten gibt es auch noch chains die vor bzw nach der
routing entscheidung durchlaufen werden. diese sind in der "nat" tabele.

iptables -t nat -L -n 



beim entwurf einer firewall hat man 2 moeglichkeiten: entweder man laesst
alles grundsaetzlich durch und filtert nur einzelne ports oder man sperrt
grundsaetzlich alles und laesst nur noch explizit erlaubte zugriffe durch.

* erste methode ist nur ratsam wenn man schnell mal eine gefahr auf einem
laufenden system abwenden will ohne gefahr zu laufen sachen abzusperen
die erlaubt sein sollten.

* generell (und vorallem fuer neu aufgesetzte systeme) ist zweitere methode
zu bevorzugen. denn dabei kann es nicht passieren dass man offen loecher
vergisst...

alles zu sperren kann man entweder machen indem man die "policy" auf DROP
stellt oder in dem man darauf achtet als letzte rule einer chain immer
ein -j DROP zu haben.

eine gute firewall sollte angriffe auch loggen. fuer diesen zweck gibt es
u.a. das target -j LOG

iptables -j LOG -A INPUT -p icmp -m limit --limit 4/s -j LOG \
--log-level info --log-prefix "mein erstes icmp filter "

wuerde alle icmp packete (ping verwendet z.b. ICMP ECHO packete) in ein
log file schreiben. aber maximal 4 pro sekunde (damit ein hacker nicht
unser logfile ueberfluten kann). das limitieren geht ueber das modul
"limit" (-m limit).

will man z.b. die meisten der packete die man DROPT auch logen so koennte
man sich eine eigene chain definieren in die man dann das logen uebergibt
und am ende der chain hat man dann ein -j DROP

iptables -N LOGDROP
iptables -A LOGDROP -m limit --limit 4/s -j LOG \
--log-level info --log-prefix "packet droped "
iptables -A LOGDROP -j DROP

unsere regel die das drucker port beschuetzt koennten wir jetzt z.b. so
schreiben:

iptables -A INPUT -p tcp --dport 515 -j LOGDROP

die das packet in unsere LOGDROP chain stellt und dort erst droped nachdem
es einen eintrag im logfile hinterlassen hat.

bis jetzt haben wir nur auf --dport (destination port) gemacht. man kann
aber auch auf source addressen, source ports und andere felder von IP bzw
TCP packeten matchen:

iptables -A FORWARD -p tcp -s 192.168.0.0/24 -d 192.168.11.12/32 -j ACCEPT

obiges wuerde z.b. alle tcp packete aus dem netz 192.168.0.0/24 zum
rechner 192.168.11.12 erlauben. (-s steht fuer source -d fuer destination)

viele argumente erlauben auch ein ! davor dass dann verneinung bedeutet. 
das waeren dann genau alle packete die NICHT der entsprechenden angabe
enstprechen.

oft will man tcp verbindungen nur in eine richtung erlauben. problem ist
natuerlich dass bei einer verbindung immer auch retourpackte durchkommen
muessen. zum glueck ist es so dass der aufbau einer tcp verbundgen mit
einem speziellen flag erfolgt (SYN):

iptables -A FORWARD -p tcp --syn -d 192.168.0.0/24 -s 192.168.11.12/32 -j DROP

obiges wuerde z.b. alle packete von 192.168.11.12 nach 192.168.0.0/24
sperren die zum aufbau einer tcp verbindung benoetigt werden.

iptables haben auch einen mechanismus eingebaut um verbindungen zu
verfolgen. also sich zu merken wann eine verbindung aufgebaut und wieder
abgebaut wird.. man kann damit z.b. nur packete erlauben die teil einer
bestehenden tcp verbindung sind ( das geht mit -m state).

als letztes in unserer kurzuebersicht ueber iptables wollen wir uns dem
NAT (network address translation) auch MASQUERADING genannt.

es gibt 4 targets zum umschreiben von packeten:

* SNAT (source NAT) zum umschreiben der source addresse mit dem switch
--to-source kann man eine ip addresse (oder einen bereich von ip
addressen) angeben auf den die source addresse umgeschrieben wird. SNAT
ist nur in der POSTROUTING chain (oder in chains die von dort aus
aufgerufen werden) gueltig. man kann so ein netz mit privaten addressen
mit oeffentlichen IPs tarnen:

iptables -t nat -I POSTROUTING -j SNAT -s 10.0.0.0/8 -d 0/0 --to-source 123.45.67.89

obige regel wuerde alle packete aus dem 10.x.x.x netz egal wohin sie
gehen so erscheinen lassen als wuerden sie von 123.45.67.89 ausgehen. 
antwort packete die zu einer bestehenden verbindung gehoeren werden
ebenfalls umgeschrieben so dass die packete zur maschine geroutet werden
die die verbindung aufgebaut hat. ist also obige maschine der default
gateway zum internet mit der ip 123.45.67.89 und dahinter steckt ein
grosses privates 10.x.x.x netz so koennen alle rechner von dort aus das
internet benutzen.. fuer alle aussenstehenden rechner scheint es aber
als wuerden alle packte von 123.45.67.89 ausgehen.

aenhlich wie SNAT ist

* MASQUERADE bei diesem braucht man keine --to-source addresse angeben
sondern es wird automatisch die addresse des ausgehenden interfaces
genommen. das ist praktisch wenn man z.b. eine ppp verbindung zu seinem
provider hat auf der man eine dynamsich zugewiesene addresse hat. mit einer
statischen addresse sollte man SNAT vorziehen.

* DNAT (destination NAT) zum umschreiben der zieladdresse. DNAT ist nur in
der PREROUTING oder in der OUTPUT chain erlaubt. mit dem switch
--to-destination ipaddresse kann man die destination ip addresse
umschreiben. damit kann man z.b. interne rechner von aussen erreichbar
machen.

aehnlich wie DNAT ist

* REDIRECT. REDIRECT leitet packte zu einem lokalen port weiter. will man
z.b. webzigriff sprerren aber den surfen sagen warum sie nicht direkt
nach aussen surfen duerfen koennte man z.b. alle zugriffe auf port 80 zu
einem lokalen webserver weiterleiten der erklaert warum die user nicht
zugreifen duerfen.
EXERCISES:

* versuche eine workstation mit linux so zu schuezten dass sie nur noch
tcp verbindungen nach aussen machen kann und keine eingehenden tcp
verbindungen mehr akzeptiert. (ausser einige speziell ausgenommen.. z.b. 
ssh (port 22) von bestimmen maschinen aus). sperre auch alle UDP packete
mit ausnahme von abfragen deiner nameserver.

* ergaenze obige firewall um eine log funktion die nicht erlaubte zugriffe
in ein logfile schreibt

* setzte einen gateway mit SNAT auf der ein privates lan transparent nach
aussen connecten laesst.
