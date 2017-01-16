"NIC
                    Network Information Center
"FQDN    
                    Fully qualified domain name
"/etc/hosts          
                    zuweisen on ip, FQDN
                        127.0.0.1
                        ::1
                        localhost
                        ip6-localhost

"/etc/resolv.conf    
                    tempor. konfig vioon DNS-CLients, bis zum nächsten reboot
                        domain
                        search
                        namenserver

                         /etc/hostname = /proc/sys/kernel/hostname      
                    Name des Systems -depracated

"/etc/hosts          
                    hinter 127.0.0.1 steht der hostname

"/etc/networks       
                    Nameauflösung für Hostname und für Netzwerkadressen

"/etc/nsswitch.conf  
                    Suchfolge für Namensaulösung und Netzwerk
                        hosts:          files mdns4_minimal [NOTFOUND=return] dns mdns4
                        networks:       files dns
                                files           /etc/hosts
                                mdns4_minimal   automatisch konfiguriertes “Heim-Netzwerk”
                                dns             wenn keine NamenAuflösung, dann /etc/resolv.conf
                                mdns4           per default kenn alle root DNS-Server. Bei änderung /etc/hosts
                                                        zB. hosts:    dns files mdns4
                                                            networks: dns files

"nmtool              
                    Network-Manager Tool

"nmcli               
                    Network-MAnager Tool

"ifconfig [ NIC ] [ IP ] [ NM ] [ up | down ]
                    NUR für kabelgebundene Netzwerke
                            ifconfig eth0 up    direkte Zuweisung der IP möglich
                            ifconfig -a         deaktivierte Netzwerkadapter
                            ifconfig eth0       zeigt Informationen NUR für den Adapter eth0
                            ifconfig eth0 192.168.5.55 netmask 255.255.255.0    Zuweisen einer statischen IP an eine Netzwerkkarte
                            ip a show eth0    == ifconfig eth0
                            ip a (or ip addr) == ifconfig -a

"ifup / ifdown   
                    = ifconfig up /down
                    /etc/network/interfaces

"/etc/network/interfaces
                    Beispielkonfigurationen
                    1.  IP-Zuweisung per DHCP für eth0
                            iface eth0 inet dhcp
                            auto eth0
                    2.  statische IP-Zuweisung
                            iface eth0 inet static
                                address 192.168.2.37
                                netmask 255.255.255.0
                                network 192.168.2.0
                            (optional)
                                broadcast 192.168.2.255
                            (optional) sonst resolv.conf
                                gateway
                                192.168.2.1
                                [[dns-nameservers 192.168.2.1 8.8.8.8 ]

"route [ -n ]        
                    gesetze route, -n keine NamensAuflösung
                        Ziel             Router          Genmask             Flags Metric Ref Use Iface
                        192.168.2.0     0.0.0.0          255.255.255.0        U     1       0   0   eth0
                        10.0.5.0        192.168.2.2      255.255.255.0       UG     1       0   0   eth0
                        172.16.2.3      192.168.2.3      255.255.255.0       ugh    1       0   0   eth0
                        0.0.0.0         192.168.2.1      0.0.0.0             UG     0       0   0   eth0
                            Der erste Eintrag ist die Standard-Definition des eigenen
                                Netzes.Alle Pakete, die im eigenen Netzsegment ein Ziel haben und
                                somit intern bleiben, werden durch den eigenen NIC mittels
                                dem Ethernet-Protokoll zugestellt.
                            Der letzte Eintrag ist die Definition des Standard-
                                Gateways. Kann ein Paket nicht direkt zugestellt werden, so wird das
                                Paket an eine geeignete Route weitergegeben. Sollte keine
                                der eingetragenen Routen greifen, bleibt nur noch der Weg
                                zum Default-Gateway, der quasi die letzte Instanz nach
                                außen darstellt.
                            In dem Beispiel gibt es zwei zusätzliche Routingeinträge:
                                Der Eintrag der zweiten Zeile besagt, dass jedes Paket,
                                dessen Ziel sich in dem Netz 10.0.5.0/24 befindet über den
                                Router/PC 192.168.2.2 geleitet wird. Dieser kümmert sich
                                qanschließend um den weiteren Versand und die Zustellung am
                                Empfänger
                            Eine neue Route hinzufügen - Grundlagen
                                Der angegebene Gateway MUSS sich im SELBEN
                                Netzwerksegment befinden, wie der Rechner, auf dem die Route
                                definiert wird! Der route-Befehl prüft dies und weist darauf hin
                                (ebenfalls - je nach Implementation - auch, wenn das Gateway
                                nicht existiert).
                       /proc/net/route, /proc/net/ipv6_route, /proc/net/rt_cache.

"route add default gw <IP>
                    default Gateway setzen
"route add -net  172.16.2.0 netmask 255.255.255.0 gw 192.168.2.40
                    route Route für ein Zielnetz
"route add -host 172.16.2.22 netmask 255.255.255.0 gw 192.168.2.41
                    route für einen einzelnen Host
"route del -host 172.16.2.22  
                    route entfernen
"route del -net 172.16.2.0   
                    route entfernen
  Flags:
    U       up - route activ
    G       router als Gateway 
    H       Host - wenn x.x.x.0 + H - Netzwerk wird nicht funzen
    R       dynamische Route
    D       Daemon oder Redirectpaket. Bei nicht aktiv, wird entfert
    M       wie oben aber es wird eine bestehende Route verwendet  

"dhclient -r eth0
                    vorhandene IP mit DCP anfordern

"service network(ing) start/stop
                        Netzwerk starten/stopen
"service network-manager stop/stop

"netstat 
                    Diagnosetool depracated
                    fragt /proc/net/tcp                    
    -a      zeigt alle Verbindungen
    -r      routinginformation
    -n      numerisch, schnell, ohne Namensauflösung
    -i      listenform
    -C      continous (wie tail-f)

"ss                 
                    ersetzt netstat.  Fragt direkt den Kernel ab - adurch schneller
                  

