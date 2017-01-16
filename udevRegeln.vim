1. Regeln anlegen in:
    /etc/udev/rules.d/  
    /lib/udev/rules.d  - Kopie
    (0-99) Zshlen Priorisierung - höhere Zahlen - spätere Rules
    60 - Userregeln  
    55 - zB. usbstick_aktenkoffer

Informationen über Geräte erhalten:
    Block-Device:
        udevadm info -a -p $(udevadm info -q path -n /dev/sdd1)
        # hilfreich ist, die Infos per Skript auszuwerten oder für eine udev-Rule in eine 
        Datei umzuleiten

lsusb - liefert geeignete identifikationsmerkmale/steuerattribute   
        - einzelne partitionen des gerätes
        - einzelne chipsätze, controller
        - adapter (z.b. usb auf sata) oder lesegeräte
        - subsysteme, wie verschiedene usb systeme (1.0, 1.1, 2.0, 3.0)
        - linux-treiber (z.b. ehci_hcd)
        Wenn man änderungen gemacht hat, ist udev neu zu starten
        "/etc/init.d/udev restart

Troubleshooting:
        austausch von netzwerkkarten
        falls man die netzwerkkarte (lan oder wlan) austauscht, wird die neue zwar im 
        Regelfall automatisch erkannt, aber die bezeichnung hochgezählt (aus ehemals eth0 wird z.b. eth2). 
        die zuordnung findet in der datei /etc/udev/rules.d/70-persistent-net.rules statt 
        und kann darüber (mit root-rechten) angepasst werden. 
        Anschließend ist ein neustart des systems erforderlich.

Beispiele:
    funktion der usb-ports deaktivieren
        bus=="usb", options+="ignore_device"
            der effekt dieser regel wäre, das alle usb-geräte an allen ports nicht mehr funktionieren
            - unabhängig von ihrer klasse - also neben speichermedien auch drucker, mäuse, tastaturen etc.

    funtion der blockorientierten speichermedien deaktivieren
        bus=="usb", subsystem=="block", options+="ignore_device"
            hier werden in der folge dieser regel keine usb-speichermedien mehr erkannt 
            - nützlich für die informationssicherheit in einem unternehmen.

    ide-festplatte (hier sdb) einen namen zuweisen
        kernel=="sdb", name="festplatte b"
            dies lässt sich natürlich auf vielerlei art anpassen.
            die 2. festplatte, die sich am system anmeldet ignorieren

    für eine sata-festplatte
        bus=="usb", kernel=="sdb", options+="ignore_device"

    für eine ide-festplatte
        bus=="usb", kernel=="hdb", options+="ignore_device"

    einen symbolischen link zum namen einer spezifischen usb-maus anlegen
        subsystem=="input", bus=="usb", sysfs{serial}=="0000:00:1d.0", symlink+=="2400dpi-maus"
            anzupassen wäre hier der device node basierend auf dem hersteller-namen

    einen usb-stick identifizieren    
        bus=="usb", sysfs{manufacturer}=="jetflash", name="aktenkoffer"                                   
            eine solche regel würde beim erkennen (==einstecken) des herstellernamens "jetflash"
            den namen des device-nodes als 'aktenkoffer' anzeigen.

    selektiv usb blockdevices erlauben mit einem externen skript/programm
        bus=="usb", subsystem=="block", program="/bin/was_auch_immer_das_ding_tut", 
        result!="meins", options+="ignore_device" bei einer solchen regel hängt es sehr davon ab, 
        was das ergebnis (==result) des programs  "was_auch_immer_das_ding_tut" ist 
            - in diesem fall bedeutet die abfrage, 
        dass das programm mit etwas anderem (kann auch ==returncode sein) als "meins" geantwortet hat 
        (also die antwort ist hier nicht(!) "meins") 
        - als folge wird die anmeldung des devices ignoriert.

Links:
        http://wiki.ubuntuusers.de/udev
        http://reactivated.net/writing_udev_rules.html
        videos:
        https://www.youtube.com/watch?v=bfwli2igls0
        https://www.youtube.com/watch?v=ymezt9sgqpu
        https://www.youtube.com/watch?v=qt4scuwbs2i

"/etc/udev/rules.d/70-persistant-net.rules

Auszug aus Datei: 70-persistent-net.rules:
        #pci device 0x11ab:0x4354 (sky2)
        subsystem=="net", action=="add", drivers=="?*", attr{address}=="00:13:77:f6:f2:3a", 
        attr{dev_id}=="0x0", attr{type}=="1", kernel=="eth*", name="eth0"udev-regeln
        UBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="00:13:77:f6:f2:3a", 
        ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"
