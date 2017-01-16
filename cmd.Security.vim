intetd              SuperDaemon (package: inetutils-inetd) (depracated)
                    tcp-wrapper ist separat (tcpd)
                    /etc/inetd.conf
                    Feld1   Feld2     Feld3     Feld4       Feld5    Feld6              Feld7
                    ftp     stream      tcp     nowait      root    /usr/sbin/tcpd /    usr/sbin/proftpd

                        1. Name des Dienstes  = /etc/services und ersetzt Port - hier 21 (ftp)
                        2. Typ der Verbindung
                            stream - verbindung tcp
                            dgram  - verbindung udp
                            andere: seqpacket, rdm, raw
                        3. Das Protokoll
                        4. Warte-Flag
                            wait - Bei wait wird der Serverdienst erst dann gestartet,
                                    wenn die /etc/hosts.allow & /etc/hosts.deny geprüft
                                    wurde und ein Zugriff berechtigt ist.
                                    Nachteil bei wait:
                                    Das starten des Dienstes dauert einige Sekunden
                                    länger
                            nowait- Servedienst wird gestartet zeitgleich mit überprüfung 
                                    von hosts.allow + hosts.deny  
                                    Nachteil bei nowait: 
                                    Der Dienst wird auch gestartet, wenn er
                                    im Endeffekt nicht benutzt wird.
                        5. Userkontext - nur root darf die Ports öffnen
                        6. Pfad zum  Wrapper
                        7. Absoluter pfad zu der Binary des Diensstes
                
/etc/host.allow/deny    host.allow hat Vorgang!
                        Wenn IP-range in allow angegeben, so muss in deny (ALL : ALL) stehen.
                        Wenn beide Dateien leer, dann alle dürfen.
                        Regel: in deny alles verbieten und in allow Ausnahmen machen.
                        Syntax: [<RICHTUNG>.]<DIENST> : <WER> [<BEDINGUNG ODER AKTION>]
                           WER             Wildcards, IPs, IP-Ranges, Domains
                           BEDINGUNG       /
                           AKTION          Hier können Wildcards und Kommandos stehen
                           WILDCARDS
                           ALL             keine Einschränkung. Jeder darf
                           LOCAL           jeder, der sich in meiner IP-Range
                                           (meinem lokalen Netzwerk) oder meiner
                                           Domain befindet darf
                           KNOWN           jeder, der seine Identität (IP,
                                           hostname) Preis gibt, darf
                           UNKNOWN         jeder, der seine Identität NICHT Preis
                                           gibt darf
                           PARANOID        jeder, der seine Identität faked oder
                                           verschleiert darf AUSNAHMSLOS ALLES!!!
                                           Daher diese Wildcard mit Vorsicht
                                           genießen! In der Praxis nur wirklich
                                           sinnvoll in der hosts.deny!
                           EXCEPT          Dienste und Hosts exceptions. 
                                           Ausnahmen kommasepariert angegeben

                        :# /etc/hosts.allow: list of hosts that are allowed to access the system.
                           ALL: LOCAL, .S.wbs.local
                        :# /etc/hosts.deny: list of hosts that are _not_ allowed to access the
                        system.
                            ALL: PARANOID

/etc/nologin        unterbindet SSH aber nicht empfehlenswert, denn anmeldung nicht möglich. 
                    Besser ssh zu stoppen


xinetd              Superdaemon        
                    xconv.pl < /etc/inetd.conf > xinetd.conf                  konvertieren inetd2xinetd
                    itox -daemon_dir /usr/sbin < inetd.conf > xinetd.conf     konvertieren inetd2xinetd
                                                                              (depracated)
                     /etc/xinetd.conf:  "include /etc/xinetd/*"
                    "service xinetd reload"
        
                    Beispielkonfig: FTP > /etc/xintetd.d/ftp.conf > service ftp (wie in /etc/services)
                                disabled        =   no
                                socket_type     =   stream
                                protocol        =   tcp
                                wait            =   no
                                user            =   root
                                server          =   /usr/sbin/proftpd
                                server_args     =   -V
                                port            =   2141
                                interface       =   192.168.54.2
                                bind            =   192.168.54.2  - alternative zu  "interface"
                                only_from       =   116.54.88.0
                                no_access       =   116.54.87.15
                                access_times    =   10:00-14:00
                                log_on_failures =   +ATTEMPT 

xconv.pl < /etc/inetd.conf > xinetd.conf                  konvertieren inetd2xinetd
itox -daemon_dir /usr/sbin < inetd.conf > xinetd.conf     konvertieren inetd2xinetd(depracated)
                          
tcp-wrapper
    1. mit Superdaemon ist sicherer.
                                              tcp-wrapper:
           Anfrage     Berechtigungsprüfung   tcpd mit Zugangsregeln
           Netzwerk         xinetd            allow/deny                 Dienste
            °-----------------°--------- ----------°--------------------°ftp,rshd.telnetd,talked
                    
    2. ohne Superdaemon
           Der Dienst muss sich selbst um die Zugriffsrechte der Clients kümmern. 
           Risiko beim Authorisierung ist erhöht.

            
