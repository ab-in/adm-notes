Proxy-Server

    Ein Proxyserver ist ein Computer, der als Mittler zwischen einem Webbrowser (wie Firefox) und dem Internet fungiert. 
    Der Klassiker unter den Proxyservern in Linux ist der Squid. Proxyserver steigern die Leistung im Web, indem sie 
    eine Kopie häufig verwendeter Webseiten speichern. Wenn ein Browser eine Webseite anfordert, die in der Sammlung 
    des Proxyservers gespeichert ist (in seinem Cache), wird diese Seite vom Proxyserver bereitgestellt, was schneller geht, 
    als sie aus dem Web abzurufen. Proxyserver erhöhen auch die Sicherheit, indem sie - nach Konfiguration oder in Zusammenarbeit mit AddOns 
    wie Squidguard oder OpenDNS - einige Webinhalte und Malware herausfiltern. Ab Squid3 gibt es dann auch die ICAP-Schnittstelle 
    (Internet Content Adaption Protocol), die es möglich macht Virenscanner oder Content-Filter (z.B. Packet Inspection!) anzusprechen.

    Proxyserver werden vor allem in den Netzwerken von Organisationen und Unternehmen verwendet - meist unter dem Aspekt der Zugangskontrolle, 
    bei meist stehenden Internetverbindungen mit unbegrenztem Datenvolumen gerät die Caching-Funktion immer mehr in den Hintergrund.

Proxy-Arten
===========

Lokaler Proxy

    Ein lokaler Proxy ist ein Proxyserver, der entweder auf dem Quell- oder Zielsystem eingesetzt wird. Er nistet sich zwischen dem Browser
    des Clients und dem Internet ein. Lokale Proxys werden meist als Filter oder Konverter benutzt.

Transparenter Proxy

    Ein transparenter Proxy ist so konfiguriert, dass er nach extern hin als Proxyserver erkennbar ist und alle Clientanfragen 
    und Browserdaten nahezu unverändert weiterreicht. Hierbei werden auch unter Umständen die IP-Adressen der Clients weitergereicht. 
    Beim Einsatz eines Routers im kleinen Netzwerk ist ein transparenter Proxy nicht notwendig, da der Router nach außen hin nur eine 
    IP-Adresse übermittelt und die IP-Adressen der Clients verborgen bleiben.

Anonymer Proxy

    Ein anonymer Proxy ist so konfiguriert, dass er nach extern hin als Proxyserver erkennbar ist und alle Clientanfragen weiterreicht. 
    Die IP-Adressen der Clients werden verborgen. Hiermit ist nach korrekter Einstellung der Filter- und Anonymisierungs-Optionen eine 
    Verschleierung der Browserdaten der Clients möglich. Zu beachten ist jedoch, dass die IP-Adresse des Routers stets sichtbar ist 
    und immer auch als IP-Adresse des anonymen Proxys erscheint. Die IP-Adresse kann nicht verschleiert oder verborgen werden. 
    Da jedoch die IP-Adresse des Routers im Internet "lautstark" behauptet, ein Proxy zu sein, erschwert es Datensammlern die Rückverfolgung. 
    Abgesehen davon werden einige Browserdaten vorenthalten, was wiederum die Wiedererkennung erschwert. Diese Art des Proxyservers eignet sich, 
    um als lokaler Proxy eingesetzt zu werden.

    http://www.debianhelp.org/node/1713

Unsichtbarer (Elite) Proxy

    Ein unsichtbarer (Elite) Proxy ist im wesentlichen ein anonymer Proxy, der verheimlicht, ein Proxyserver zu sein. 
    Er ist so konfiguriert, dass er nach extern unsichtbar ist und alle Clientanfragen weiterreicht. Die lokalen IP-Adressen der Clients werden verborgen. 
    Zusätzlich verschleiern korrekte Filter- und Anonymisierungs-Optionen viele Einzelheiten über die Clients. Allerdings sind solche Proxys 
    nicht gern gesehen, da die absolute Verschleierung die RFC-Standards verletzt. Diese Art des Proxyservers kann auch als lokaler Proxyserver Anwendung finden.

    http://www.dataparadis.net/osp/gnu-linux-server/proxy-server/high-anonymous-elite-proxy-with-squid/

Squid Caching Proxy

	Installation Squid 3-Proxy

	apt-get install squid3 || aptitude install squid3

	Konfiguration (paketbasiert)

		/etc/squid3/squid.conf

	Installation Squid-Proxy

	apt-get install squid3 || aptitude install squid3

	Konfiguration (paketbasiert - Grundkonfiguration)

		/etc/squid3/squid.conf

		# acl manager proto cache_object
		# acl localhost src 127.0.0.1/32 ::1
		# acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1

		acl SSL_ports port 443
		acl Safe_ports port 80          # http
		acl Safe_ports port 21          # ftp
		acl Safe_ports port 443         # https
		acl Safe_ports port 70          # gopher
		acl Safe_ports port 210         # wais
		acl Safe_ports port 1025-65535  # unregistered ports
		acl Safe_ports port 280         # http-mgmt
		acl Safe_ports port 488         # gss-http
		acl Safe_ports port 591         # filemaker
		acl Safe_ports port 777         # multiling http
		acl CONNECT method CONNECT

		# clients allowed to connect
		acl ip_acl src 10.0.2.0/24

		# http_access allow manager localhost
		http_access deny manager
		http_access deny !Safe_ports
		http_access deny CONNECT !SSL_ports
		# http_access allow localhost

		# really allow
		http_access allow ip_acl	# Zugriffsadressen von ip_acl erlauben
		http_access deny all		# restliche Zugriffe verwerfen
									# HINWEIS: alle anderen Direktiven http_access
									# müssen vor diesem Eintrag liegen (Reihenfolge!)

		coredump_dir /var/spool/squid3	#Abildspeicherort - wenn Programm abstürzt

		# refresh_patterns: http://www.squid-cache.org/Doc/config/refresh_pattern/
		# https://www.safaribooksonline.com/library/view/squid-the-definitive/0596001622/ch07s07.html

		refresh_pattern ^ftp:           1440    20%     10080
		refresh_pattern ^gopher:        1440    0%      1440
		refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
		refresh_pattern .               0       20%     4320

		#User block
		visible_hostname proxy				# angezeigter Hostame
		cache_mgr root@proxy.s.wbs.local	# angezeigter Admin
		shutdown_lifetime 10 seconds		# Cache Timeout [s] nach SIGTERM/SIGHUP 

		# WBS Proxy > eigener Proxy
		cache_peer 10.140.2.10 parent 3128 0 no-query default 	# Proxy WBS
		never_direct allow all									# erlaubt ACLs

		# never_direct: http://www.squid-cache.org/Doc/config/never_direct/

		# listen on 10.0.2.10
		http_port 10.0.2.10:3128		# Konfiguration für einen Server mit 2 NICs
										# ansonsten reicht theoretisch der Port
										
	Filter-ACLs
	
	Anlegen einer ACL
	
		Squids acl-Optionen: http://www.squid-cache.org/Doc/config/acl/

		Eintrag in der /etc/squid.config

			acl <Namen der Liste> <acl-Typ> <Netz, IP, Benutzer>
			http_access <allow | deny> NameDerListe

		Beispiel 1
		Ich möchte den Zugang auf die Seite www.schmutzfink.org für den Client mit der IP 192.168.44.142 sperren

			acl hoststop src 192.168.44.142 urlpath_regex -i ^www.schmutzfink.org
			http_access deny hoststop

		HINWEIS: der reguläre Ausdruck muss - je nach Seite und deren Aufruf - weiter gefasst werden. So ist ggf. auch die Filterung ds Protokolls (http / https) notwendig - 
		
		Beispiel 2
		In einer Datei “verboten.list” sind alle Seiten in Form von RegularExpressions hinterlegt, die aus dem Netz 172.16.0.0/24 nicht erreichbar sein dürfen. Nachteil der Konfiguration - IP werden NICHT aufgehalten! auch ist es schwer maximal verbreitete Dienste wie Google o.ä. auszusperren. Eine Whitelist ist nur mit Zugangsbeschränkung (min. User/Passwort) möglich.

			acl verbot urlpath_regex "/etc/squid[3]verboten.list" src 172.16.0.0/255.255.255.0
			http_access deny verbot
			
			alternativ:
			
			acl verbot dstdomain "/etc/squid[3]/verboten.list" src 172.16.0.0/255.255.255.0
			http_access deny verbot
			
			Andere Möglichkeiten:
			
			acl aclname srcdomain   .foo.com ...
			# reverse lookup, from client IP [slow]

			acl aclname dstdomain [-n] .foo.com ...
			# Destination server from URL [fast]

			acl aclname srcdom_regex [-i] \.foo\.com ...
			# regex matching client name [slow]

			acl aclname dstdom_regex [-n] [-i] \.foo\.com ...
			# regex matching server [fast]

			# For dstdomain and dstdom_regex a reverse lookup is tried if a IP
			# based URL is used and no match is found. The name "none" is used
			# if the reverse lookup fails.

		Beispiel 3
		Alle Seiten, in deren URL das Wort “facebook” vorkommt darf von niemanden angesteuert werden

			acl face urlpath_regex 
			http_access deny face
			
			Andere Möglichkeiten:
			
			acl aclname url_regex [-i] ^http:// ...
			# regex matching on whole URL [fast]

			acl aclname urllogin [-i] [^a-zA-Z0-9] ...
			# regex matching on URL login field

			acl aclname urlpath_regex [-i] \.gif$ ...
			# regex matching on URL path [fast]

		Beispiel 4 - "Öffnungszeiten":
		acl verboten time <Tage> <h1:m1 - h2:m2>

			konkret z.B.:
			
			acl verboten time 19:00-6:00
			http_access deny verboten 
		
		Tage: 	S - Sunday
				M - Monday
				T - Tuesday
				W - Wednesday
				H - Thursday
				F - Friday
				A - Saturday
		
		

	Clientkonfiguration

	Iceweasel/Firefox

	Menu > Preferences > Advanced > Network > Connection [Settings]

	HTTP Proxy: 	IP des Proxys (hier 10.0.2.10) Port (hier:3128)
					+ anhaken: use this proxy server for all protocols
					
	Kontrolle des Clients über iptables - Transparenter Squid-Proxy
	
	An dieser Stelle der squid.conf wird der Squid als transparentet Proxy definiert:
	
		# Squid normally listens to port 3128
		http_port 3128 transparent
	
	Soll/will man nicht (je)den Client einstellen, kann man ein Routing für die Datenpakete auf den Server durchführen:
	
		# iptables -A PREROUTING -t nat -i eth1 -p tcp --dport 80 -j REDIRECT --to-port 3128
		
	Der Server wird nun alle TCP-Pakete von eth1 mit Zielport 80 auf den Squid-Port 3128 umleiten. Voraussetzung ist aktiviertes IP-Forwarding!	Man benötigt logischerweise eine solche Regel von JEDEM Subnetz, in unserem Fall eben auch eth2.
	
	Zugangsbeschränkungen zum Proxyserver - Userauthentifikation gegen Passwortdatei oder PAM

	Userauthentifikation (Basis-NCSA-Authentifizierung mit User/Passwort)

	Prüfen, ob (basic_)ncsa_auth vorhanden

	DEB: /usr/lib/squid3/basic_ncsa_auth
	RHEL: /usr/lib64/squid3/ncsa_auth

	Generierung des Passwortfiles

	Die Generierung des benötigten Passwort-Files werden wir mit Hilfe des Programmes htpasswd aus dem RPM-Paket httpd-tools, bzw. dem DPKG-Paket apache2-tools vornehmen.

	Für den Fall, dass das betreffende RPM-Paket/DPKG-Paket im System noch nicht installiert wurde, werden wir dies eben dieses mit Hilfe von yum/apt nachholen.

		RHEL: # yum install httpd-tools -y
		DEB:  # apt-get install apache2-tools	# sind i.d.R. vorhanden (> .htaccess)
	
	Anschließend legen wir uns ein entsprechendes Passwortfile (mit dem User held) an:

		# htpasswd -c /etc/squid/passwd held

			New password: 
			Re-type new password: 
			Adding password for user held

			Die Option -c verwenden wir, da das File noch nicht existiert und wir eine entsprechende Datei anlegen wollen. Alle weiteren User werden dann mit Hilfe des folgenden Befehls an die Datei angefügt.

		# htpasswd /etc/squid/passwd boba

			 New password: 
			 Re-type new password: 
			 Adding password for user boba

	In der Datei /etc/squid/passwd befinden sich nun zwei Einträge für die beiden Nutzer mit ihren zugehörigen verschlüsselten Passwörtern.

		# cat /etc/squid/passwd

			held:dLuUSr1crTPjtq1pQA
			boba:9VqG33k1rE72HUPCLc

	Konfiguration /etc/squid/squid.conf

	Unsere zentrale Konfigurationsdatei ergänzen wir dann entsprechend für unsere NCSA-Benutzerauthentifizierung.

		# vim /etc/squid/squid.conf

		Am Anfang der /etc/squid3/squid.conf (> NCSA-Authentifizierung (User/Passwort))

			auth_param basic program /usr/lib/squid3/basic_ncsa_auth 	/etc/squid/passwd
			auth_param basic children 4
			auth_param basic utf8 on
			auth_param basic realm Bitte geben Sie Ihren Benutzernamen und Passwort fuer die Internetberechtigung ein!
			auth_param basic credentialsttl 60 minutes
			auth_param basic casesensitive off

		im Definitions-Block

		acl ncsa_users proxy_auth REQUIRED
		
		vor der deny all-Zeile

		http_access allow localhost ncsa_users
		http_access allow localnet ncsa_users
		
		Automatisierung der PW-Übergabe:
		
		http_proxy=http://USERNAME:PASSWORD@PROXYIP:PROXYPORT
		
	Userauthentifikation (Authentifizierung gegen ein Plugable Authentication Module (PAM) mit User/Passwort)

		Die User werden normal mit adduser / useradd angeleget, allerdings mit einer Shell /bin/false, wenn nur der (hier: Proxy-) Dienst genutzt werden soll.
		
		Ansonsten in der /etc/squid3/squid.conf folgende Konfiguration eintragen:

		Am Anfang der /etc/squid3/squid.conf
		
		auth_param basic program /usr/lib/squid/pam_auth
		auth_param basic children 5
		auth_param basic realm Squid proxy_caching web-server
		auth_param basic credentialsttl 1 hour 
		auth_param basic casesensitive off
		
		im Definitions-Block
		
		acl checkpw prox_auth REQUIRED
		
		vor der deny all-Zeile
		
		http_access allow checkpw all

	Filtereinstellungen von Squid
	
	URL-Filter mit Squid3

	Sperrliste anlegen

	/etc/squid3/gesperrt

	Inhalt:
	porn
	sex
	warez
	cracks
	debian

	Konfiguration ergänzen (ACL)

	acl gesperrt url_regex -i "/etc/squid3/gesperrt"
	http_access deny gesperrt

	URL-Filter mittels Squidguard

	Installation

		# apt-get install squidguard

		Aufbereiten und Einbinden der Blacklist und Konfiguration:
		http://www.cyberciti.biz/faq/squidguard-web-filter-block-websites/

	Konfiguration

		http://www.squidguard.org/Doc/configure.html

		Aufbereiten der Liste (s.d.a. Link) am Beispiel Shallalist

	Liste laden und aufbereiten

		# cd /tmp
		# wget -c http://www.shallalist.de/Downloads/shallalist.tar.gz
		# tar -zxvf shallalist.tar.gz
		# cp -avr BL/porn/ /var/lib/squidguard/db/

	Dateien für Squidguard erzeugen

		# cd /var/lib/squidguard/db/porn
		# squidGuard -b -C domains
		# squidGuard -b -C urls

	Verzeichnis-Rechte an Squid übertragen

		chown proxy:proxy -R /var/lib/squidguard/db/

	Squid für Squidguard konfigurieren

	/etc/squid3/squid.conf
	 
		# nano /etc/squid3/squid.conf
	 
		url_rewrite_program /usr/bin/squidGuard		# URL an Squidguard weitergeben

	Squidguard konfigurieren

	/etc/squidguard/squidGuard.conf

		# nano /etc/squidguard/squidGuard.conf

	Einfache Konfiguration

		dbhome /var/lib/squidguard/db			# Lage der erzeugten Sperrdateien
		logdir /var/log/squidguard				# Lage des Logfiles squidGuard.log


		Beispiel-Destination gegen Adult-Content (nach Shallalist)

		dest porn {
				domainlist      porn/domains		#relativ zum dbhome
				urllist         porn/urls
		}
		 

		Beispiel-ACL gegen Adult-Content

		acl {
				default {
						pass  !porn all
						redirect [was immer gewünscht - wird bei einem Match aufgerufen]
				}
		}


		Beispiel-ACL - Umgehung durch IP verhindern

		acl {
				default {
						pass  !porn !in-addr all
						redirect [was immer gewünscht - wird bei einem Match aufgerufen]
				}
		}

	Andere / erweiterte Konfigurationsbeispiele

	http://www.squidguard.org/Doc/configure.html

	Testen von Squidguard

	echo "http://sex.com / - - GET" | squidGuard -d


	2012-08-22 01:26:05 [3365] no ACL matching source, using default
	http://[Umleitungsadresse]
	2012-08-22 01:26:05 [3365] squidGuard stopped (1345578965.477)

	Test im Browser

	Aufruf einer gesperrten Seite ruft den definierten Redirect auf.

	Sicherheitstipps

	Browser und Betriebsystem fälschen
	
		header_replace User-Agent Gozilla/4711.0815 (CP/M; 11-bit; 59 MByte)
	
	in die Datei squid.conf eintragen. Funktioniert allerdings nur bei vorherigem Löschen des echten User-Agent mit	
	
		header_access User-Agent deny all
	
	Nach User-Agent kann man jeden beliebigen Text eintragen, es kann jedoch zu Problemen mit schlecht konfigurierten Servern kommen.
	
	Absender-Info einschränken
	
	Um zu verhindern, daß unnötige Informationen aus dem internen Netz nach außen gelangen, sollte man dies mit
		
		anonymize_headers deny Via und
		anonymize_headers deny X-Forwarded-For
	
	unterbinden. Welche Header genau nach außen gehen, kann man mit ngrep herausfinden.
	*Warnung: Squid muß mit der Option 'anonymize_headers on' compiliert sein, was nicht immer der Fall ist!
