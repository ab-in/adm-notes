
		    LINUX ALLOCATED DEVICES (2.6+ version)

	     Maintained by Torben Mathiasen <device@lanana.org>

		      Last revised: 25 January 2005

This list is the Linux Device List, the official registry of allocated
device numbers and /dev directory nodes for the Linux operating
system.

The latest version of this list is available from
http://www.lanana.org/docs/device-list/ or
ftp://ftp.kernel.org/pub/linux/docs/device-list/.  This version may be
newer than the one distributed with the Linux kernel.

The LaTeX version of this document is no longer maintained.

This document is included by reference into the Filesystem Hierarchy
Standard (FHS).	 The FHS is available from http://www.pathname.com/fhs/.

Allocations marked (68k/Amiga) apply to Linux/68k on the Amiga
platform only.	Allocations marked (68k/Atari) apply to Linux/68k on
the Atari platform only.

The symbol {2.6} means the allocation is obsolete and scheduled for
removal once kernel version 2.6 (or equivalent) is released. Some of these
allocations have already been removed.

This document is in the public domain.	The author requests, however,
that semantically altered versions are not distributed without
permission of the author, assuming the author can be contacted without
an unreasonable effort.

In particular, please don't sent patches for this list to Linus, at
least not without contacting me first.

I do not have any information about these devices beyond what appears
on this list.  Any such information requests will be deleted without
reply.


	  **** DEVICE DRIVERS AUTHORS PLEASE READ THIS ****

To have a major number allocated, or a minor number in situations
where that applies (e.g. busmice), please contact me with the
appropriate device information.	 Also, if you have additional
information regarding any of the devices listed below, or if I have
made a mistake, I would greatly appreciate a note.

I do, however, make a few requests about the nature of your report.
This is necessary for me to be able to keep this list up to date and
correct in a timely manner.  First of all, *please* send it to the
correct address... <device@lanana.org>.  I receive hundreds of email
messages a day, so mail sent to other addresses may very well get lost
in the avalanche.  Please put in a descriptive subject, so I can find
your mail again should I need to.  Too many people send me email
saying just "device number request" in the subject.

Second, please include a description of the device *in the same format
as this list*.	The reason for this is that it is the only way I have
found to ensure I have all the requisite information to publish your
device and avoid conflicts.

Third, please don't assume that the distributed version of the list is
up to date.  Due to the number of registrations I have to maintain it
in "batch mode", so there is likely additional registrations that
haven't been listed yet.

Finally, sometimes I have to play "namespace police."  Please don't be
offended.  I often get submissions for /dev names that would be bound
to cause conflicts down the road.  I am trying to avoid getting in a
situation where we would have to suffer an incompatible forward
change.  Therefore, please consult with me *before* you make your
device names and numbers in any way public, at least to the point
where it would be at all difficult to get them changed.

Your cooperation is appreciated.


  0		Unnamed devices (e.g. non-device mounts)
		  0 = reserved as null device number
		See block major 144, 145, 146 for expansion areas.

  1 char	Memory devices
		  1 = /dev/mem		Physical memory access
		  2 = /dev/kmem		Kernel virtual memory access
		  3 = /dev/null		Null device
		  4 = /dev/port		I/O port access
		  5 = /dev/zero		Null byte source
		  6 = /dev/core		OBSOLETE - replaced by /proc/kcore
		  7 = /dev/full		Returns ENOSPC on write
		  8 = /dev/random	Nondeterministic random number gen.
		  9 = /dev/urandom	Faster, less secure random number gen.
		 10 = /dev/aio		Asyncronous I/O notification interface
		 11 = /dev/kmsg		Writes to this come out as printk's
  1 block	RAM disk
		  0 = /dev/ram0		First RAM disk
		  1 = /dev/ram1		Second RAM disk
		    ...
		250 = /dev/initrd	Initial RAM disk {2.6}

		Older kernels had /dev/ramdisk (1, 1) here.
		/dev/initrd refers to a RAM disk which was preloaded
		by the boot loader; newer kernels use /dev/ram0 for
		the initrd.

  2 char	Pseudo-TTY masters
		  0 = /dev/ptyp0	First PTY master
		  1 = /dev/ptyp1	Second PTY master
		    ...
		255 = /dev/ptyef	256th PTY master

		Pseudo-tty's are named as follows:
		* Masters are "pty", slaves are "tty";
		* the fourth letter is one of pqrstuvwxyzabcde indicating
		  the 1st through 16th series of 16 pseudo-ttys each, and
		* the fifth letter is one of 0123456789abcdef indicating
		  the position within the series.

		These are the old-style (BSD) PTY devices; Unix98
		devices are on major 128 and above and use the PTY
		master multiplex (/dev/ptmx) to acquire a PTY on
		demand.
  
  2 block	Floppy disks
		  0 = /dev/fd0		Controller 0, drive 0, autodetect
		  1 = /dev/fd1		Controller 0, drive 1, autodetect
		  2 = /dev/fd2		Controller 0, drive 2, autodetect
		  3 = /dev/fd3		Controller 0, drive 3, autodetect
		128 = /dev/fd4		Controller 1, drive 0, autodetect
		129 = /dev/fd5		Controller 1, drive 1, autodetect
		130 = /dev/fd6		Controller 1, drive 2, autodetect
		131 = /dev/fd7		Controller 1, drive 3, autodetect

		To specify format, add to the autodetect device number:
		  0 = /dev/fd?		Autodetect format
		  4 = /dev/fd?d360	5.25"  360K in a 360K  drive(1)
		 20 = /dev/fd?h360	5.25"  360K in a 1200K drive(1)
		 48 = /dev/fd?h410	5.25"  410K in a 1200K drive
		 64 = /dev/fd?h420	5.25"  420K in a 1200K drive
		 24 = /dev/fd?h720	5.25"  720K in a 1200K drive
		 80 = /dev/fd?h880	5.25"  880K in a 1200K drive(1)
		  8 = /dev/fd?h1200	5.25" 1200K in a 1200K drive(1)
		 40 = /dev/fd?h1440	5.25" 1440K in a 1200K drive(1)
		 56 = /dev/fd?h1476	5.25" 1476K in a 1200K drive
		 72 = /dev/fd?h1494	5.25" 1494K in a 1200K drive
		 92 = /dev/fd?h1600	5.25" 1600K in a 1200K drive(1)

		 12 = /dev/fd?u360	3.5"   360K Double Density(2)
		 16 = /dev/fd?u720	3.5"   720K Double Density(1)
		120 = /dev/fd?u800	3.5"   800K Double Density(2)
		 52 = /dev/fd?u820	3.5"   820K Double Density
		 68 = /dev/fd?u830	3.5"   830K Double Density
		 84 = /dev/fd?u1040	3.5"  1040K Double Density(1)
		 88 = /dev/fd?u1120	3.5"  1120K Double Density(1)
		 28 = /dev/fd?u1440	3.5"  1440K High Density(1)
		124 = /dev/fd?u1600	3.5"  1600K High Density(1)
		 44 = /dev/fd?u1680	3.5"  1680K High Density(3)
		 60 = /dev/fd?u1722	3.5"  1722K High Density
		 76 = /dev/fd?u1743	3.5"  1743K High Density
		 96 = /dev/fd?u1760	3.5"  1760K High Density
		116 = /dev/fd?u1840	3.5"  1840K High Density(3)
		100 = /dev/fd?u1920	3.5"  1920K High Density(1)
		 32 = /dev/fd?u2880	3.5"  2880K Extra Density(1)
		104 = /dev/fd?u3200	3.5"  3200K Extra Density
		108 = /dev/fd?u3520	3.5"  3520K Extra Density
		112 = /dev/fd?u3840	3.5"  3840K Extra Density(1)

		 36 = /dev/fd?CompaQ	Compaq 2880K drive; obsolete?

		(1) Autodetectable format
		(2) Autodetectable format in a Double Density (720K) drive only
		(3) Autodetectable format in a High Density (1440K) drive only

		NOTE: The letter in the device name (d, q, h or u)
		signifies the type of drive: 5.25" Double Density (d),
		5.25" Quad Density (q), 5.25" High Density (h) or 3.5"
		(any model, u).	 The use of the capital letters D, H
		and E for the 3.5" models have been deprecated, since
		the drive type is insignificant for these devices.

  3 char	Pseudo-TTY slaves
		  0 = /dev/ttyp0	First PTY slave
		  1 = /dev/ttyp1	Second PTY slave
		    ...
		255 = /dev/ttyef	256th PTY slave

		These are the old-style (BSD) PTY devices; Unix98
		devices are on major 136 and above.

  3 block	First MFM, RLL and IDE hard disk/CD-ROM interface
		  0 = /dev/hda		Master: whole disk (or CD-ROM)
		 64 = /dev/hdb		Slave: whole disk (or CD-ROM)

		For partitions, add to the whole disk device number:
		  0 = /dev/hd?		Whole disk
		  1 = /dev/hd?1		First partition
		  2 = /dev/hd?2		Second partition
		    ...
		 63 = /dev/hd?63	63rd partition

		For Linux/i386, partitions 1-4 are the primary
		partitions, and 5 and above are logical partitions.
		Other versions of Linux use partitioning schemes
		appropriate to their respective architectures.

  4 char	TTY devices
		  0 = /dev/tty0		Current virtual console

		  1 = /dev/tty1		First virtual console
		    ...
		 63 = /dev/tty63	63rd virtual console
		 64 = /dev/ttyS0	First UART serial port
		    ...
		255 = /dev/ttyS191	192nd UART serial port

		UART serial ports refer to 8250/16450/16550 series devices.

		Older versions of the Linux kernel used this major
		number for BSD PTY devices.  As of Linux 2.1.115, this
		is no longer supported.	 Use major numbers 2 and 3.

  4 block	Aliases for dynamically allocated major devices to be used
		when its not possible to create the real device nodes
		because the root filesystem is mounted read-only.

                  0 = /dev/root

  5 char	Alternate TTY devices
		  0 = /dev/tty		Current TTY device
		  1 = /dev/console	System console
		  2 = /dev/ptmx		PTY master multiplex
		 64 = /dev/cua0		Callout device for ttyS0
		    ...
		255 = /dev/cua191	Callout device for ttyS191

		(5,1) is /dev/console starting with Linux 2.1.71.  See
		the section on terminal devices for more information
		on /dev/console.

  6 char	Parallel printer devices
		  0 = /dev/lp0		Parallel printer on parport0
		  1 = /dev/lp1		Parallel printer on parport1
		    ...

		Current Linux kernels no longer have a fixed mapping
		between parallel ports and I/O addresses.  Instead,
		they are redirected through the parport multiplex layer.

  7 char	Virtual console capture devices
		  0 = /dev/vcs		Current vc text contents
		  1 = /dev/vcs1		tty1 text contents
		    ...
		 63 = /dev/vcs63	tty63 text contents
		128 = /dev/vcsa		Current vc text/attribute contents
		129 = /dev/vcsa1	tty1 text/attribute contents
		    ...
		191 = /dev/vcsa63	tty63 text/attribute contents
	
		NOTE: These devices permit both read and write access.

  7 block	Loopback devices
		  0 = /dev/loop0	First loopback device
		  1 = /dev/loop1	Second loopback device
		    ...

		The loopback devices are used to mount filesystems not
		associated with block devices.	The binding to the
		loopback devices is handled by mount(8) or losetup(8).

  8 block	SCSI disk devices (0-15)
		  0 = /dev/sda		First SCSI disk whole disk
		 16 = /dev/sdb		Second SCSI disk whole disk
		 32 = /dev/sdc		Third SCSI disk whole disk
		    ...
		240 = /dev/sdp		Sixteenth SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

  9 char	SCSI tape devices
		  0 = /dev/st0		First SCSI tape, mode 0
		  1 = /dev/st1		Second SCSI tape, mode 0
		    ...
		 32 = /dev/st0l		First SCSI tape, mode 1
		 33 = /dev/st1l		Second SCSI tape, mode 1
		    ...
		 64 = /dev/st0m		First SCSI tape, mode 2
		 65 = /dev/st1m		Second SCSI tape, mode 2
		    ...
		 96 = /dev/st0a		First SCSI tape, mode 3
		 97 = /dev/st1a		Second SCSI tape, mode 3
		      ...
		128 = /dev/nst0		First SCSI tape, mode 0, no rewind
		129 = /dev/nst1		Second SCSI tape, mode 0, no rewind
		    ...
		160 = /dev/nst0l	First SCSI tape, mode 1, no rewind
		161 = /dev/nst1l	Second SCSI tape, mode 1, no rewind
		    ...
		192 = /dev/nst0m	First SCSI tape, mode 2, no rewind
		193 = /dev/nst1m	Second SCSI tape, mode 2, no rewind
		    ...
		224 = /dev/nst0a	First SCSI tape, mode 3, no rewind
		225 = /dev/nst1a	Second SCSI tape, mode 3, no rewind
		    ...

		"No rewind" refers to the omission of the default
		automatic rewind on device close.  The MTREW or MTOFFL
		ioctl()'s can be used to rewind the tape regardless of
		the device used to access it.

  9 block	Metadisk (RAID) devices
		  0 = /dev/md0		First metadisk group
		  1 = /dev/md1		Second metadisk group
		    ...

		The metadisk driver is used to span a
		filesystem across multiple physical disks.

 10 char	Non-serial mice, misc features
		  0 = /dev/logibm	Logitech bus mouse
		  1 = /dev/psaux	PS/2-style mouse port
		  2 = /dev/inportbm	Microsoft Inport bus mouse
		  3 = /dev/atibm	ATI XL bus mouse
		  4 = /dev/jbm		J-mouse
		  4 = /dev/amigamouse	Amiga mouse (68k/Amiga)
		  5 = /dev/atarimouse	Atari mouse
		  6 = /dev/sunmouse	Sun mouse
		  7 = /dev/amigamouse1	Second Amiga mouse
		  8 = /dev/smouse	Simple serial mouse driver
		  9 = /dev/pc110pad	IBM PC-110 digitizer pad
		 10 = /dev/adbmouse	Apple Desktop Bus mouse
		 11 = /dev/vrtpanel	Vr41xx embedded touch panel
		 13 = /dev/vpcmouse	Connectix Virtual PC Mouse
		 14 = /dev/touchscreen/ucb1x00  UCB 1x00 touchscreen
		 15 = /dev/touchscreen/mk712	MK712 touchscreen
		128 = /dev/beep		Fancy beep device
		129 = /dev/modreq	Kernel module load request {2.6}
		130 = /dev/watchdog	Watchdog timer port
		131 = /dev/temperature	Machine internal temperature
		132 = /dev/hwtrap	Hardware fault trap
		133 = /dev/exttrp	External device trap
		134 = /dev/apm_bios	Advanced Power Management BIOS
		135 = /dev/rtc		Real Time Clock
		139 = /dev/openprom	SPARC OpenBoot PROM
		140 = /dev/relay8	Berkshire Products Octal relay card
		141 = /dev/relay16	Berkshire Products ISO-16 relay card
		142 = /dev/msr		x86 model-specific registers {2.6}
		143 = /dev/pciconf	PCI configuration space
		144 = /dev/nvram	Non-volatile configuration RAM
		145 = /dev/hfmodem	Soundcard shortwave modem control {2.6}
		146 = /dev/graphics	Linux/SGI graphics device
		147 = /dev/opengl	Linux/SGI OpenGL pipe
		148 = /dev/gfx		Linux/SGI graphics effects device
		149 = /dev/input/mouse	Linux/SGI Irix emulation mouse
		150 = /dev/input/keyboard Linux/SGI Irix emulation keyboard
		151 = /dev/led		Front panel LEDs
		152 = /dev/kpoll	Kernel Poll Driver
		153 = /dev/mergemem	Memory merge device
		154 = /dev/pmu		Macintosh PowerBook power manager
		155 = /dev/isictl	MultiTech ISICom serial control
		156 = /dev/lcd		Front panel LCD display
		157 = /dev/ac		Applicom Intl Profibus card
		158 = /dev/nwbutton	Netwinder external button
		159 = /dev/nwdebug	Netwinder debug interface
		160 = /dev/nwflash	Netwinder flash memory
		161 = /dev/userdma	User-space DMA access
		162 = /dev/smbus	System Management Bus
		163 = /dev/lik		Logitech Internet Keyboard
		164 = /dev/ipmo		Intel Intelligent Platform Management
		165 = /dev/vmmon	VMWare virtual machine monitor
		166 = /dev/i2o/ctl	I2O configuration manager
		167 = /dev/specialix_sxctl Specialix serial control
		168 = /dev/tcldrv	Technology Concepts serial control
		169 = /dev/specialix_rioctl Specialix RIO serial control
		170 = /dev/thinkpad/thinkpad	IBM Thinkpad devices
		171 = /dev/srripc	QNX4 API IPC manager
		172 = /dev/usemaclone	Semaphore clone device
		173 = /dev/ipmikcs	Intelligent Platform Management
		174 = /dev/uctrl	SPARCbook 3 microcontroller
		175 = /dev/agpgart	AGP Graphics Address Remapping Table
		176 = /dev/gtrsc	Gorgy Timing radio clock
		177 = /dev/cbm		Serial CBM bus
		178 = /dev/jsflash	JavaStation OS flash SIMM
		179 = /dev/xsvc		High-speed shared-mem/semaphore service
		180 = /dev/vrbuttons	Vr41xx button input device
		181 = /dev/toshiba	Toshiba laptop SMM support
		182 = /dev/perfctr	Performance-monitoring counters
		183 = /dev/hwrng	Generic random number generator
		184 = /dev/cpu/microcode CPU microcode update interface
		186 = /dev/atomicps	Atomic shapshot of process state data
		187 = /dev/irnet	IrNET device
		188 = /dev/smbusbios	SMBus BIOS
		189 = /dev/ussp_ctl	User space serial port control
		190 = /dev/crash	Mission Critical Linux crash dump facility
		191 = /dev/pcl181	<information missing>
		192 = /dev/nas_xbus	NAS xbus LCD/buttons access
		193 = /dev/d7s		SPARC 7-segment display
		194 = /dev/zkshim	Zero-Knowledge network shim control
		195 = /dev/elographics/e2201	Elographics touchscreen E271-2201
		198 = /dev/sexec	Signed executable interface
		199 = /dev/scanners/cuecat :CueCat barcode scanner
		200 = /dev/net/tun	TAP/TUN network device
		201 = /dev/button/gulpb	Transmeta GULP-B buttons
		202 = /dev/emd/ctl	Enhanced Metadisk RAID (EMD) control
		204 = /dev/video/em8300		EM8300 DVD decoder control
		205 = /dev/video/em8300_mv	EM8300 DVD decoder video
		206 = /dev/video/em8300_ma	EM8300 DVD decoder audio
		207 = /dev/video/em8300_sp	EM8300 DVD decoder subpicture
		208 = /dev/compaq/cpqphpc	Compaq PCI Hot Plug Controller
		209 = /dev/compaq/cpqrid	Compaq Remote Insight Driver
		210 = /dev/impi/bt	IMPI coprocessor block transfer	
		211 = /dev/impi/smic	IMPI coprocessor stream interface
		212 = /dev/watchdogs/0	First watchdog device
		213 = /dev/watchdogs/1	Second watchdog device
		214 = /dev/watchdogs/2	Third watchdog device
		215 = /dev/watchdogs/3	Fourth watchdog device
		216 = /dev/fujitsu/apanel	Fujitsu/Siemens application panel
		217 = /dev/ni/natmotn		National Instruments Motion
		218 = /dev/kchuid	Inter-process chuid control
		219 = /dev/modems/mwave	MWave modem firmware upload
		220 = /dev/mptctl	Message passing technology (MPT) control
		221 = /dev/mvista/hssdsi	Montavista PICMG hot swap system driver
		222 = /dev/mvista/hasi		Montavista PICMG high availability
		223 = /dev/input/uinput		User level driver support for input
		224 = /dev/tpm		TCPA TPM driver
		225 = /dev/pps		Pulse Per Second driver
		226 = /dev/systrace	Systrace device
		227 = /dev/mcelog	X86_64 Machine Check Exception driver
		228 = /dev/hpet		HPET driver
		229 = /dev/fuse		Fuse (virtual filesystem in user-space)
		230 = /dev/midishare	MidiShare driver
		240-254			Reserved for local use
		255			Reserved for MISC_DYNAMIC_MINOR

 11 char	Raw keyboard device	(Linux/SPARC only)
		  0 = /dev/kbd		Raw keyboard device

 11 char	Serial Mux device	(Linux/PA-RISC only)
		  0 = /dev/ttyB0	First mux port
		  1 = /dev/ttyB1	Second mux port
		    ...

 11 block	SCSI CD-ROM devices
		  0 = /dev/scd0		First SCSI CD-ROM
		  1 = /dev/scd1		Second SCSI CD-ROM
		    ...

		The prefix /dev/sr (instead of /dev/scd) has been deprecated.

 12 char	QIC-02 tape
		  2 = /dev/ntpqic11	QIC-11, no rewind-on-close
		  3 = /dev/tpqic11	QIC-11, rewind-on-close
		  4 = /dev/ntpqic24	QIC-24, no rewind-on-close
		  5 = /dev/tpqic24	QIC-24, rewind-on-close
		  6 = /dev/ntpqic120	QIC-120, no rewind-on-close
		  7 = /dev/tpqic120	QIC-120, rewind-on-close
		  8 = /dev/ntpqic150	QIC-150, no rewind-on-close
		  9 = /dev/tpqic150	QIC-150, rewind-on-close

		The device names specified are proposed -- if there
		are "standard" names for these devices, please let me know.

 12 block	MSCDEX CD-ROM callback support {2.6}
		  0 = /dev/dos_cd0	First MSCDEX CD-ROM
		  1 = /dev/dos_cd1	Second MSCDEX CD-ROM
		    ...

 13 char	Input core
		  0 = /dev/input/js0	First joystick
		  1 = /dev/input/js1	Second joystick
		    ...
		 32 = /dev/input/mouse0	First mouse
		 33 = /dev/input/mouse1	Second mouse
		    ...
		 63 = /dev/input/mice	Unified mouse
		 64 = /dev/input/event0	First event queue
		 65 = /dev/input/event1	Second event queue
		    ...

		Each device type has 5 bits (32 minors).

 13 block	8-bit MFM/RLL/IDE controller
		  0 = /dev/xda		First XT disk whole disk
		 64 = /dev/xdb		Second XT disk whole disk

		Partitions are handled in the same way as IDE disks
		(see major number 3).

 14 char	Open Sound System (OSS)
		  0 = /dev/mixer	Mixer control
		  1 = /dev/sequencer	Audio sequencer
		  2 = /dev/midi00	First MIDI port
		  3 = /dev/dsp		Digital audio
		  4 = /dev/audio	Sun-compatible digital audio
		  6 = /dev/sndstat	Sound card status information {2.6}
		  7 = /dev/audioctl	SPARC audio control device
		  8 = /dev/sequencer2	Sequencer -- alternate device
		 16 = /dev/mixer1	Second soundcard mixer control
		 17 = /dev/patmgr0	Sequencer patch manager
		 18 = /dev/midi01	Second MIDI port
		 19 = /dev/dsp1		Second soundcard digital audio
		 20 = /dev/audio1	Second soundcard Sun digital audio
		 33 = /dev/patmgr1	Sequencer patch manager
		 34 = /dev/midi02	Third MIDI port
		 50 = /dev/midi03	Fourth MIDI port
 14 block	BIOS harddrive callback support {2.6}
		  0 = /dev/dos_hda	First BIOS harddrive whole disk
		 64 = /dev/dos_hdb	Second BIOS harddrive whole disk
		128 = /dev/dos_hdc	Third BIOS harddrive whole disk
		192 = /dev/dos_hdd	Fourth BIOS harddrive whole disk

		Partitions are handled in the same way as IDE disks
		(see major number 3).

 15 char	Joystick
		  0 = /dev/js0		First analog joystick
		  1 = /dev/js1		Second analog joystick
		    ...
		128 = /dev/djs0		First digital joystick
		129 = /dev/djs1		Second digital joystick
		    ...
 15 block	Sony CDU-31A/CDU-33A CD-ROM
		  0 = /dev/sonycd	Sony CDU-31a CD-ROM

 16 char	Non-SCSI scanners
		  0 = /dev/gs4500	Genius 4500 handheld scanner
 16 block	GoldStar CD-ROM
		  0 = /dev/gscd		GoldStar CD-ROM

 17 char	Chase serial card
		  0 = /dev/ttyH0	First Chase port
		  1 = /dev/ttyH1	Second Chase port
		    ...
 17 block	Optics Storage CD-ROM
		  0 = /dev/optcd	Optics Storage CD-ROM

 18 char	Chase serial card - alternate devices
		  0 = /dev/cuh0		Callout device for ttyH0
		  1 = /dev/cuh1		Callout device for ttyH1
		    ...
 18 block	Sanyo CD-ROM
		  0 = /dev/sjcd		Sanyo CD-ROM

 19 char	Cyclades serial card
		  0 = /dev/ttyC0	First Cyclades port
		    ...
		 31 = /dev/ttyC31	32nd Cyclades port
 19 block	"Double" compressed disk
		  0 = /dev/double0	First compressed disk
		    ...
		  7 = /dev/double7	Eighth compressed disk
		128 = /dev/cdouble0	Mirror of first compressed disk
		    ...
		135 = /dev/cdouble7	Mirror of eighth compressed disk

		See the Double documentation for the meaning of the
		mirror devices.

 20 char	Cyclades serial card - alternate devices
		  0 = /dev/cub0		Callout device for ttyC0
		    ...
		 31 = /dev/cub31	Callout device for ttyC31
 20 block	Hitachi CD-ROM (under development)
		  0 = /dev/hitcd	Hitachi CD-ROM

 21 char	Generic SCSI access
		  0 = /dev/sg0		First generic SCSI device
		  1 = /dev/sg1		Second generic SCSI device
		    ...

		Most distributions name these /dev/sga, /dev/sgb...;
		this sets an unnecessary limit of 26 SCSI devices in
		the system and is counter to standard Linux
		device-naming practice.

 21 block	Acorn MFM hard drive interface
		  0 = /dev/mfma		First MFM drive whole disk
		 64 = /dev/mfmb		Second MFM drive whole disk

		This device is used on the ARM-based Acorn RiscPC.
		Partitions are handled the same way as for IDE disks
		(see major number 3). 

 22 char	Digiboard serial card
		  0 = /dev/ttyD0	First Digiboard port
		  1 = /dev/ttyD1	Second Digiboard port
		    ...
 22 block	Second IDE hard disk/CD-ROM interface
		  0 = /dev/hdc		Master: whole disk (or CD-ROM)
		 64 = /dev/hdd		Slave: whole disk (or CD-ROM)
		
		Partitions are handled the same way as for the first
		interface (see major number 3).

 23 char	Digiboard serial card - alternate devices
		  0 = /dev/cud0		Callout device for ttyD0
		  1 = /dev/cud1		Callout device for ttyD1
		      ...
 23 block	Mitsumi proprietary CD-ROM
		  0 = /dev/mcd		Mitsumi CD-ROM

 24 char	Stallion serial card
		  0 = /dev/ttyE0	Stallion port 0 card 0
		  1 = /dev/ttyE1	Stallion port 1 card 0
		    ...
		 64 = /dev/ttyE64	Stallion port 0 card 1
		 65 = /dev/ttyE65	Stallion port 1 card 1
		      ...
		128 = /dev/ttyE128	Stallion port 0 card 2
		129 = /dev/ttyE129	Stallion port 1 card 2
		    ...
		192 = /dev/ttyE192	Stallion port 0 card 3
		193 = /dev/ttyE193	Stallion port 1 card 3
		    ...
 24 block	Sony CDU-535 CD-ROM
		  0 = /dev/cdu535	Sony CDU-535 CD-ROM

 25 char	Stallion serial card - alternate devices
		  0 = /dev/cue0		Callout device for ttyE0
		  1 = /dev/cue1		Callout device for ttyE1
		    ...
		 64 = /dev/cue64	Callout device for ttyE64
		 65 = /dev/cue65	Callout device for ttyE65
		    ...
		128 = /dev/cue128	Callout device for ttyE128
		129 = /dev/cue129	Callout device for ttyE129
		    ...
		192 = /dev/cue192	Callout device for ttyE192
		193 = /dev/cue193	Callout device for ttyE193
		      ...
 25 block	First Matsushita (Panasonic/SoundBlaster) CD-ROM
		  0 = /dev/sbpcd0	Panasonic CD-ROM controller 0 unit 0
		  1 = /dev/sbpcd1	Panasonic CD-ROM controller 0 unit 1
		  2 = /dev/sbpcd2	Panasonic CD-ROM controller 0 unit 2
		  3 = /dev/sbpcd3	Panasonic CD-ROM controller 0 unit 3

 26 char	Quanta WinVision frame grabber {2.6}
		  0 = /dev/wvisfgrab	Quanta WinVision frame grabber
 26 block	Second Matsushita (Panasonic/SoundBlaster) CD-ROM
		  0 = /dev/sbpcd4	Panasonic CD-ROM controller 1 unit 0
		  1 = /dev/sbpcd5	Panasonic CD-ROM controller 1 unit 1
		  2 = /dev/sbpcd6	Panasonic CD-ROM controller 1 unit 2
		  3 = /dev/sbpcd7	Panasonic CD-ROM controller 1 unit 3

 27 char	QIC-117 tape
		  0 = /dev/qft0		Unit 0, rewind-on-close
		  1 = /dev/qft1		Unit 1, rewind-on-close
		  2 = /dev/qft2		Unit 2, rewind-on-close
		  3 = /dev/qft3		Unit 3, rewind-on-close
		  4 = /dev/nqft0	Unit 0, no rewind-on-close
		  5 = /dev/nqft1	Unit 1, no rewind-on-close
		  6 = /dev/nqft2	Unit 2, no rewind-on-close
		  7 = /dev/nqft3	Unit 3, no rewind-on-close
		 16 = /dev/zqft0	Unit 0, rewind-on-close, compression
		 17 = /dev/zqft1	Unit 1, rewind-on-close, compression
		 18 = /dev/zqft2	Unit 2, rewind-on-close, compression
		 19 = /dev/zqft3	Unit 3, rewind-on-close, compression
		 20 = /dev/nzqft0	Unit 0, no rewind-on-close, compression
		 21 = /dev/nzqft1	Unit 1, no rewind-on-close, compression
		 22 = /dev/nzqft2	Unit 2, no rewind-on-close, compression
		 23 = /dev/nzqft3	Unit 3, no rewind-on-close, compression
		 32 = /dev/rawqft0	Unit 0, rewind-on-close, no file marks
		 33 = /dev/rawqft1	Unit 1, rewind-on-close, no file marks
		 34 = /dev/rawqft2	Unit 2, rewind-on-close, no file marks
		 35 = /dev/rawqft3	Unit 3, rewind-on-close, no file marks
		 36 = /dev/nrawqft0	Unit 0, no rewind-on-close, no file marks
		 37 = /dev/nrawqft1	Unit 1, no rewind-on-close, no file marks
		 38 = /dev/nrawqft2	Unit 2, no rewind-on-close, no file marks
		 39 = /dev/nrawqft3	Unit 3, no rewind-on-close, no file marks
 27 block	Third Matsushita (Panasonic/SoundBlaster) CD-ROM
		  0 = /dev/sbpcd8	Panasonic CD-ROM controller 2 unit 0
		  1 = /dev/sbpcd9	Panasonic CD-ROM controller 2 unit 1
		  2 = /dev/sbpcd10	Panasonic CD-ROM controller 2 unit 2
		  3 = /dev/sbpcd11	Panasonic CD-ROM controller 2 unit 3

 28 char	Stallion serial card - card programming
		  0 = /dev/staliomem0	First Stallion card I/O memory
		  1 = /dev/staliomem1	Second Stallion card I/O memory
		  2 = /dev/staliomem2	Third Stallion card I/O memory
		  3 = /dev/staliomem3	Fourth Stallion card I/O memory
 28 char	Atari SLM ACSI laser printer (68k/Atari)
		  0 = /dev/slm0		First SLM laser printer
		  1 = /dev/slm1		Second SLM laser printer
		    ...
 28 block	Fourth Matsushita (Panasonic/SoundBlaster) CD-ROM
		  0 = /dev/sbpcd12	Panasonic CD-ROM controller 3 unit 0
		  1 = /dev/sbpcd13	Panasonic CD-ROM controller 3 unit 1
		  2 = /dev/sbpcd14	Panasonic CD-ROM controller 3 unit 2
		  3 = /dev/sbpcd15	Panasonic CD-ROM controller 3 unit 3
 28 block	ACSI disk (68k/Atari)
		  0 = /dev/ada		First ACSI disk whole disk
		 16 = /dev/adb		Second ACSI disk whole disk
		 32 = /dev/adc		Third ACSI disk whole disk
		    ...
		240 = /dev/adp		16th ACSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15, like SCSI.

 29 char	Universal frame buffer
		  0 = /dev/fb0		First frame buffer
		  1 = /dev/fb1		Second frame buffer
		    ...
		 31 = /dev/fb31		32nd frame buffer

 29 block	Aztech/Orchid/Okano/Wearnes CD-ROM
		  0 = /dev/aztcd	Aztech CD-ROM

 30 char	iBCS-2 compatibility devices
		  0 = /dev/socksys	Socket access
		  1 = /dev/spx		SVR3 local X interface
		 32 = /dev/inet/ip	Network access
		 33 = /dev/inet/icmp
		 34 = /dev/inet/ggp
		 35 = /dev/inet/ipip
		 36 = /dev/inet/tcp
		 37 = /dev/inet/egp
		 38 = /dev/inet/pup
		 39 = /dev/inet/udp
		 40 = /dev/inet/idp
		 41 = /dev/inet/rawip

		Additionally, iBCS-2 requires the following links:

		/dev/ip -> /dev/inet/ip
		/dev/icmp -> /dev/inet/icmp
		/dev/ggp -> /dev/inet/ggp
		/dev/ipip -> /dev/inet/ipip
		/dev/tcp -> /dev/inet/tcp
		/dev/egp -> /dev/inet/egp
		/dev/pup -> /dev/inet/pup
		/dev/udp -> /dev/inet/udp
		/dev/idp -> /dev/inet/idp
		/dev/rawip -> /dev/inet/rawip
		/dev/inet/arp -> /dev/inet/udp
		/dev/inet/rip -> /dev/inet/udp
		/dev/nfsd -> /dev/socksys
		/dev/X0R -> /dev/null (? apparently not required ?)

 30 block	Philips LMS CM-205 CD-ROM
		  0 = /dev/cm205cd	Philips LMS CM-205 CD-ROM

		/dev/lmscd is an older name for this device.  This
		driver does not work with the CM-205MS CD-ROM.

 31 char	MPU-401 MIDI
		  0 = /dev/mpu401data	MPU-401 data port
		  1 = /dev/mpu401stat	MPU-401 status port
 31 block	ROM/flash memory card
		  0 = /dev/rom0		First ROM card (rw)
		      ...
		  7 = /dev/rom7		Eighth ROM card (rw)
		  8 = /dev/rrom0	First ROM card (ro)
		    ...
		 15 = /dev/rrom7	Eighth ROM card (ro)
		 16 = /dev/flash0	First flash memory card (rw)
		    ...
		 23 = /dev/flash7	Eighth flash memory card (rw)
		 24 = /dev/rflash0	First flash memory card (ro)
		    ...
		 31 = /dev/rflash7	Eighth flash memory card (ro)

		The read-write (rw) devices support back-caching
		written data in RAM, as well as writing to flash RAM
		devices.  The read-only devices (ro) support reading
		only.

 32 char	Specialix serial card
		  0 = /dev/ttyX0	First Specialix port
		  1 = /dev/ttyX1	Second Specialix port
		    ...
 32 block	Philips LMS CM-206 CD-ROM
		  0 = /dev/cm206cd	Philips LMS CM-206 CD-ROM

 33 char	Specialix serial card - alternate devices
		  0 = /dev/cux0		Callout device for ttyX0
		  1 = /dev/cux1		Callout device for ttyX1
		    ...
 33 block	Third IDE hard disk/CD-ROM interface
		  0 = /dev/hde		Master: whole disk (or CD-ROM)
		 64 = /dev/hdf		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 34 char	Z8530 HDLC driver
		  0 = /dev/scc0		First Z8530, first port
		  1 = /dev/scc1		First Z8530, second port
		  2 = /dev/scc2		Second Z8530, first port
		  3 = /dev/scc3		Second Z8530, second port
		    ...

		In a previous version these devices were named
		/dev/sc1 for /dev/scc0, /dev/sc2 for /dev/scc1, and so
		on.

 34 block	Fourth IDE hard disk/CD-ROM interface
		  0 = /dev/hdg		Master: whole disk (or CD-ROM)
		 64 = /dev/hdh		Slave: whole disk (or CD-ROM)
		
		Partitions are handled the same way as for the first
		interface (see major number 3).

 35 char	tclmidi MIDI driver
		  0 = /dev/midi0	First MIDI port, kernel timed
		  1 = /dev/midi1	Second MIDI port, kernel timed
		  2 = /dev/midi2	Third MIDI port, kernel timed
		  3 = /dev/midi3	Fourth MIDI port, kernel timed
		 64 = /dev/rmidi0	First MIDI port, untimed
		 65 = /dev/rmidi1	Second MIDI port, untimed
		 66 = /dev/rmidi2	Third MIDI port, untimed
		 67 = /dev/rmidi3	Fourth MIDI port, untimed
		128 = /dev/smpte0	First MIDI port, SMPTE timed
		129 = /dev/smpte1	Second MIDI port, SMPTE timed
		130 = /dev/smpte2	Third MIDI port, SMPTE timed
		131 = /dev/smpte3	Fourth MIDI port, SMPTE timed
 35 block	Slow memory ramdisk
		  0 = /dev/slram	Slow memory ramdisk

 36 char	Netlink support
		  0 = /dev/route	Routing, device updates, kernel to user
		  1 = /dev/skip		enSKIP security cache control
		  3 = /dev/fwmonitor	Firewall packet copies
		 16 = /dev/tap0		First Ethertap device
		    ...
		 31 = /dev/tap15	16th Ethertap device
 36 block	MCA ESDI hard disk
		  0 = /dev/eda		First ESDI disk whole disk
		 64 = /dev/edb		Second ESDI disk whole disk
		    ...

		Partitions are handled in the same way as IDE disks
		(see major number 3).

 37 char	IDE tape
		  0 = /dev/ht0		First IDE tape
		  1 = /dev/ht1		Second IDE tape
		    ...
		128 = /dev/nht0		First IDE tape, no rewind-on-close
		129 = /dev/nht1		Second IDE tape, no rewind-on-close
		    ...

		Currently, only one IDE tape drive is supported.

 37 block	Zorro II ramdisk
		  0 = /dev/z2ram	Zorro II ramdisk

 38 char	Myricom PCI Myrinet board
		  0 = /dev/mlanai0	First Myrinet board
		  1 = /dev/mlanai1	Second Myrinet board
		    ...

		This device is used for status query, board control
		and "user level packet I/O."  This board is also
		accessible as a standard networking "eth" device.

 38 block	Reserved for Linux/AP+

 39 char	ML-16P experimental I/O board
		  0 = /dev/ml16pa-a0	First card, first analog channel
		  1 = /dev/ml16pa-a1	First card, second analog channel
		    ...
		 15 = /dev/ml16pa-a15	First card, 16th analog channel
		 16 = /dev/ml16pa-d	First card, digital lines
		 17 = /dev/ml16pa-c0	First card, first counter/timer
		 18 = /dev/ml16pa-c1	First card, second counter/timer
		 19 = /dev/ml16pa-c2	First card, third counter/timer
		 32 = /dev/ml16pb-a0	Second card, first analog channel
		 33 = /dev/ml16pb-a1	Second card, second analog channel
		    ...
		 47 = /dev/ml16pb-a15	Second card, 16th analog channel
		 48 = /dev/ml16pb-d	Second card, digital lines
		 49 = /dev/ml16pb-c0	Second card, first counter/timer
		 50 = /dev/ml16pb-c1	Second card, second counter/timer
		 51 = /dev/ml16pb-c2	Second card, third counter/timer
		      ...
 39 block	Reserved for Linux/AP+

 40 char	Matrox Meteor frame grabber {2.6}
		  0 = /dev/mmetfgrab	Matrox Meteor frame grabber
 40 block	Syquest EZ135 parallel port removable drive
		  0 = /dev/eza		Parallel EZ135 drive, whole disk

		This device is obsolete and will be removed in a
		future version of Linux.  It has been replaced with
		the parallel port IDE disk driver at major number 45.
		Partitions are handled in the same way as IDE disks
		(see major number 3).

 41 char	Yet Another Micro Monitor
		  0 = /dev/yamm		Yet Another Micro Monitor
 41 block	MicroSolutions BackPack parallel port CD-ROM
		  0 = /dev/bpcd		BackPack CD-ROM

		This device is obsolete and will be removed in a
		future version of Linux.  It has been replaced with
		the parallel port ATAPI CD-ROM driver at major number 46.

 42 char	Demo/sample use
 42 block	Demo/sample use

		This number is intended for use in sample code, as
		well as a general "example" device number.  It
		should never be used for a device driver that is being
		distributed; either obtain an official number or use
		the local/experimental range.  The sudden addition or
		removal of a driver with this number should not cause
		ill effects to the system (bugs excepted.)

		IN PARTICULAR, ANY DISTRIBUTION WHICH CONTAINS A
		DEVICE DRIVER USING MAJOR NUMBER 42 IS NONCOMPLIANT.

 43 char	isdn4linux virtual modem
		  0 = /dev/ttyI0	First virtual modem
		    ...
		 63 = /dev/ttyI63	64th virtual modem
 43 block	Network block devices
		  0 = /dev/nb0		First network block device
		  1 = /dev/nb1		Second network block device
		    ...

		Network Block Device is somehow similar to loopback
		devices: If you read from it, it sends packet across
		network asking server for data. If you write to it, it
		sends packet telling server to write. It could be used
		to mounting filesystems over the net, swapping over
		the net, implementing block device in userland etc.

 44 char	isdn4linux virtual modem - alternate devices
		  0 = /dev/cui0		Callout device for ttyI0
		    ...
		 63 = /dev/cui63	Callout device for ttyI63
 44 block	Flash Translation Layer (FTL) filesystems
		  0 = /dev/ftla		FTL on first Memory Technology Device
		 16 = /dev/ftlb		FTL on second Memory Technology Device
		 32 = /dev/ftlc		FTL on third Memory Technology Device
		    ...
		240 = /dev/ftlp		FTL on 16th Memory Technology Device 

		Partitions are handled in the same way as for IDE
		disks (see major number 3) expect that the partition
		limit is 15 rather than 63 per disk (same as SCSI.)

 45 char	isdn4linux ISDN BRI driver
		  0 = /dev/isdn0	First virtual B channel raw data
		    ...
		 63 = /dev/isdn63	64th virtual B channel raw data
		 64 = /dev/isdnctrl0	First channel control/debug
		    ...
		127 = /dev/isdnctrl63	64th channel control/debug

		128 = /dev/ippp0	First SyncPPP device
		    ...
		191 = /dev/ippp63	64th SyncPPP device

		255 = /dev/isdninfo	ISDN monitor interface
 45 block	Parallel port IDE disk devices
		  0 = /dev/pda		First parallel port IDE disk
		 16 = /dev/pdb		Second parallel port IDE disk
		 32 = /dev/pdc		Third parallel port IDE disk
		 48 = /dev/pdd		Fourth parallel port IDE disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the partition
		limit is 15 rather than 63 per disk.

 46 char	Comtrol Rocketport serial card
		  0 = /dev/ttyR0	First Rocketport port
		  1 = /dev/ttyR1	Second Rocketport port
		    ...
 46 block	Parallel port ATAPI CD-ROM devices
		  0 = /dev/pcd0		First parallel port ATAPI CD-ROM
		  1 = /dev/pcd1		Second parallel port ATAPI CD-ROM
		  2 = /dev/pcd2		Third parallel port ATAPI CD-ROM
		  3 = /dev/pcd3		Fourth parallel port ATAPI CD-ROM

 47 char	Comtrol Rocketport serial card - alternate devices
		  0 = /dev/cur0		Callout device for ttyR0
		  1 = /dev/cur1		Callout device for ttyR1
		    ...
 47 block	Parallel port ATAPI disk devices
		  0 = /dev/pf0		First parallel port ATAPI disk
		  1 = /dev/pf1		Second parallel port ATAPI disk
		  2 = /dev/pf2		Third parallel port ATAPI disk
		  3 = /dev/pf3		Fourth parallel port ATAPI disk

		This driver is intended for floppy disks and similar
		devices and hence does not support partitioning.

 48 char	SDL RISCom serial card
		  0 = /dev/ttyL0	First RISCom port
		  1 = /dev/ttyL1	Second RISCom port
		    ...
 48 block	Mylex DAC960 PCI RAID controller; first controller
		  0 = /dev/rd/c0d0	First disk, whole disk
		  8 = /dev/rd/c0d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c0d31	32nd disk, whole disk

		For partitions add:
		  0 = /dev/rd/c?d?	Whole disk
		  1 = /dev/rd/c?d?p1	First partition
		    ...
		  7 = /dev/rd/c?d?p7	Seventh partition

 49 char	SDL RISCom serial card - alternate devices
		  0 = /dev/cul0		Callout device for ttyL0
		  1 = /dev/cul1		Callout device for ttyL1
		    ...
 49 block	Mylex DAC960 PCI RAID controller; second controller
		  0 = /dev/rd/c1d0	First disk, whole disk
		  8 = /dev/rd/c1d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c1d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 50 char	Reserved for GLINT

 50 block	Mylex DAC960 PCI RAID controller; third controller
		  0 = /dev/rd/c2d0	First disk, whole disk
		  8 = /dev/rd/c2d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c2d31	32nd disk, whole disk

 51 char	Baycom radio modem OR Radio Tech BIM-XXX-RS232 radio modem
		  0 = /dev/bc0		First Baycom radio modem
		  1 = /dev/bc1		Second Baycom radio modem
		    ...
 51 block	Mylex DAC960 PCI RAID controller; fourth controller
		  0 = /dev/rd/c3d0	First disk, whole disk
		  8 = /dev/rd/c3d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c3d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 52 char	Spellcaster DataComm/BRI ISDN card
		  0 = /dev/dcbri0	First DataComm card
		  1 = /dev/dcbri1	Second DataComm card
		  2 = /dev/dcbri2	Third DataComm card
		  3 = /dev/dcbri3	Fourth DataComm card
 52 block	Mylex DAC960 PCI RAID controller; fifth controller
		  0 = /dev/rd/c4d0	First disk, whole disk
		  8 = /dev/rd/c4d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c4d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 53 char	BDM interface for remote debugging MC683xx microcontrollers
		  0 = /dev/pd_bdm0	PD BDM interface on lp0
		  1 = /dev/pd_bdm1	PD BDM interface on lp1
		  2 = /dev/pd_bdm2	PD BDM interface on lp2
		  4 = /dev/icd_bdm0	ICD BDM interface on lp0
		  5 = /dev/icd_bdm1	ICD BDM interface on lp1
		  6 = /dev/icd_bdm2	ICD BDM interface on lp2

		This device is used for the interfacing to the MC683xx
		microcontrollers via Background Debug Mode by use of a
		Parallel Port interface. PD is the Motorola Public
		Domain Interface and ICD is the commercial interface
		by P&E.

 53 block	Mylex DAC960 PCI RAID controller; sixth controller
		  0 = /dev/rd/c5d0	First disk, whole disk
		  8 = /dev/rd/c5d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c5d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 54 char	Electrocardiognosis Holter serial card
		  0 = /dev/holter0	First Holter port
		  1 = /dev/holter1	Second Holter port
		  2 = /dev/holter2	Third Holter port

		A custom serial card used by Electrocardiognosis SRL
		<mseritan@ottonel.pub.ro> to transfer data from Holter
		24-hour heart monitoring equipment.

 54 block	Mylex DAC960 PCI RAID controller; seventh controller
		  0 = /dev/rd/c6d0	First disk, whole disk
		  8 = /dev/rd/c6d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c6d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 55 char	DSP56001 digital signal processor
		  0 = /dev/dsp56k	First DSP56001
 55 block	Mylex DAC960 PCI RAID controller; eigth controller
		  0 = /dev/rd/c7d0	First disk, whole disk
		  8 = /dev/rd/c7d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c7d31	32nd disk, whole disk

		Partitions are handled as for major 48.

 56 char	Apple Desktop Bus
		  0 = /dev/adb		ADB bus control

		Additional devices will be added to this number, all
		starting with /dev/adb.

 56 block	Fifth IDE hard disk/CD-ROM interface
		  0 = /dev/hdi		Master: whole disk (or CD-ROM)
		 64 = /dev/hdj		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 57 char	Hayes ESP serial card
		  0 = /dev/ttyP0	First ESP port
		  1 = /dev/ttyP1	Second ESP port
		    ...

 57 block	Sixth IDE hard disk/CD-ROM interface
		  0 = /dev/hdk		Master: whole disk (or CD-ROM)
		 64 = /dev/hdl		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 58 char	Hayes ESP serial card - alternate devices
		  0 = /dev/cup0		Callout device for ttyP0
		  1 = /dev/cup1		Callout device for ttyP1
		    ...
 58 block	Reserved for logical volume manager

 59 char	sf firewall package
		  0 = /dev/firewall	Communication with sf kernel module

 59 block	Generic PDA filesystem device
		  0 = /dev/pda0		First PDA device
		  1 = /dev/pda1		Second PDA device
		    ...

		The pda devices are used to mount filesystems on
		remote pda's (basically slow handheld machines with
		proprietary OS's and limited memory and storage
		running small fs translation drivers) through serial /
		IRDA / parallel links.

		NAMING CONFLICT -- PROPOSED REVISED NAME /dev/rpda0 etc

 60-63 char	LOCAL/EXPERIMENTAL USE
 60-63 block	LOCAL/EXPERIMENTAL USE
		Allocated for local/experimental use.  For devices not
		assigned official numbers, these ranges should be
		used in order to avoid conflicting with future assignments.

 64 char	ENskip kernel encryption package
		  0 = /dev/enskip	Communication with ENskip kernel module

 64 block	Scramdisk/DriveCrypt encrypted devices
		  0 = /dev/scramdisk/master    Master node for ioctls
		  1 = /dev/scramdisk/1         First encrypted device
		  2 = /dev/scramdisk/2         Second encrypted device
		  ...
		255 = /dev/scramdisk/255       255th encrypted device

		The filename of the encrypted container and the passwords
		are sent via ioctls (using the sdmount tool) to the master
		node which then activates them via one of the
		/dev/scramdisk/x nodes for loopback mounting (all handled
		through the sdmount tool).

		Requested by: andy@scramdisklinux.org

 65 char	Sundance "plink" Transputer boards (obsolete, unused)
		  0 = /dev/plink0	First plink device
		  1 = /dev/plink1	Second plink device
		  2 = /dev/plink2	Third plink device
		  3 = /dev/plink3	Fourth plink device
		 64 = /dev/rplink0	First plink device, raw
		 65 = /dev/rplink1	Second plink device, raw
		 66 = /dev/rplink2	Third plink device, raw
		 67 = /dev/rplink3	Fourth plink device, raw
		128 = /dev/plink0d	First plink device, debug
		129 = /dev/plink1d	Second plink device, debug
		130 = /dev/plink2d	Third plink device, debug
		131 = /dev/plink3d	Fourth plink device, debug
		192 = /dev/rplink0d	First plink device, raw, debug
		193 = /dev/rplink1d	Second plink device, raw, debug
		194 = /dev/rplink2d	Third plink device, raw, debug
		195 = /dev/rplink3d	Fourth plink device, raw, debug

		This is a commercial driver; contact James Howes
		<jth@prosig.demon.co.uk> for information.

 65 block	SCSI disk devices (16-31)
		  0 = /dev/sdq		17th SCSI disk whole disk
		 16 = /dev/sdr		18th SCSI disk whole disk
		 32 = /dev/sds		19th SCSI disk whole disk
		    ...
		240 = /dev/sdaf		32nd SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 66 char	YARC PowerPC PCI coprocessor card
		  0 = /dev/yppcpci0	First YARC card
		  1 = /dev/yppcpci1	Second YARC card
		    ...

 66 block	SCSI disk devices (32-47)
		  0 = /dev/sdag		33th SCSI disk whole disk
		 16 = /dev/sdah		34th SCSI disk whole disk
		 32 = /dev/sdai		35th SCSI disk whole disk
		    ...
		240 = /dev/sdav		48nd SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 67 char	Coda network file system
		  0 = /dev/cfs0		Coda cache manager

		See http://www.coda.cs.cmu.edu for information about Coda.

 67 block	SCSI disk devices (48-63)
		  0 = /dev/sdaw		49th SCSI disk whole disk
		 16 = /dev/sdax		50th SCSI disk whole disk
		 32 = /dev/sday		51st SCSI disk whole disk
		    ...
		240 = /dev/sdbl		64th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 68 char	CAPI 2.0 interface
		  0 = /dev/capi20	Control device
		  1 = /dev/capi20.00	First CAPI 2.0 application
		  2 = /dev/capi20.01	Second CAPI 2.0 application
		    ...
		 20 = /dev/capi20.19	19th CAPI 2.0 application

		ISDN CAPI 2.0 driver for use with CAPI 2.0
		applications; currently supports the AVM B1 card.

 68 block	SCSI disk devices (64-79)
		  0 = /dev/sdbm		65th SCSI disk whole disk
		 16 = /dev/sdbn		66th SCSI disk whole disk
		 32 = /dev/sdbo		67th SCSI disk whole disk
		    ...
		240 = /dev/sdcb		80th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 69 char	MA16 numeric accelerator card
		  0 = /dev/ma16		Board memory access

 69 block	SCSI disk devices (80-95)
		  0 = /dev/sdcc		81st SCSI disk whole disk
		 16 = /dev/sdcd		82nd SCSI disk whole disk
		 32 = /dev/sdce		83th SCSI disk whole disk
		    ...
		240 = /dev/sdcr		96th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 70 char	SpellCaster Protocol Services Interface
		  0 = /dev/apscfg	Configuration interface
		  1 = /dev/apsauth	Authentication interface
		  2 = /dev/apslog	Logging interface
		  3 = /dev/apsdbg	Debugging interface
		 64 = /dev/apsisdn	ISDN command interface
		 65 = /dev/apsasync	Async command interface
		128 = /dev/apsmon	Monitor interface

 70 block	SCSI disk devices (96-111)
		  0 = /dev/sdcs		97th SCSI disk whole disk
		 16 = /dev/sdct		98th SCSI disk whole disk
		 32 = /dev/sdcu		99th SCSI disk whole disk
		    ...
		240 = /dev/sddh		112nd SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 71 char	Computone IntelliPort II serial card
		  0 = /dev/ttyF0	IntelliPort II board 0, port 0
		  1 = /dev/ttyF1	IntelliPort II board 0, port 1
		    ...
		 63 = /dev/ttyF63	IntelliPort II board 0, port 63
		 64 = /dev/ttyF64	IntelliPort II board 1, port 0
		 65 = /dev/ttyF65	IntelliPort II board 1, port 1
		    ...
		127 = /dev/ttyF127	IntelliPort II board 1, port 63
		128 = /dev/ttyF128	IntelliPort II board 2, port 0
		129 = /dev/ttyF129	IntelliPort II board 2, port 1
		    ...
		191 = /dev/ttyF191	IntelliPort II board 2, port 63
		192 = /dev/ttyF192	IntelliPort II board 3, port 0
		193 = /dev/ttyF193	IntelliPort II board 3, port 1
		    ...
		255 = /dev/ttyF255	IntelliPort II board 3, port 63

 71 block	SCSI disk devices (112-127)
		  0 = /dev/sddi		113th SCSI disk whole disk
		 16 = /dev/sddj		114th SCSI disk whole disk
		 32 = /dev/sddk		115th SCSI disk whole disk
		    ...
		240 = /dev/sddx		128th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 72 char	Computone IntelliPort II serial card - alternate devices
		  0 = /dev/cuf0		Callout device for ttyF0
		  1 = /dev/cuf1		Callout device for ttyF1
		    ...
		 63 = /dev/cuf63	Callout device for ttyF63
		 64 = /dev/cuf64	Callout device for ttyF64
		 65 = /dev/cuf65	Callout device for ttyF65
		    ...
		127 = /dev/cuf127	Callout device for ttyF127
		128 = /dev/cuf128	Callout device for ttyF128
		129 = /dev/cuf129	Callout device for ttyF129
		    ...
		191 = /dev/cuf191	Callout device for ttyF191
		192 = /dev/cuf192	Callout device for ttyF192
		193 = /dev/cuf193	Callout device for ttyF193
		    ...
		255 = /dev/cuf255	Callout device for ttyF255

 72 block	Compaq Intelligent Drive Array, first controller
		  0 = /dev/ida/c0d0	First logical drive whole disk
		 16 = /dev/ida/c0d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c0d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

 73 char	Computone IntelliPort II serial card - control devices
		  0 = /dev/ip2ipl0	Loadware device for board 0
		  1 = /dev/ip2stat0	Status device for board 0
		  4 = /dev/ip2ipl1	Loadware device for board 1
		  5 = /dev/ip2stat1	Status device for board 1
		  8 = /dev/ip2ipl2	Loadware device for board 2
		  9 = /dev/ip2stat2	Status device for board 2
		 12 = /dev/ip2ipl3	Loadware device for board 3
		 13 = /dev/ip2stat3	Status device for board 3

 73 block	Compaq Intelligent Drive Array, second controller
		  0 = /dev/ida/c1d0	First logical drive whole disk
		 16 = /dev/ida/c1d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c1d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

 74 char	SCI bridge
		  0 = /dev/SCI/0	SCI device 0
		  1 = /dev/SCI/1	SCI device 1
		    ...

		Currently for Dolphin Interconnect Solutions' PCI-SCI
		bridge.

 74 block	Compaq Intelligent Drive Array, third controller
		  0 = /dev/ida/c2d0	First logical drive whole disk
		 16 = /dev/ida/c2d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c2d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

 75 char	Specialix IO8+ serial card
		  0 = /dev/ttyW0	First IO8+ port, first card
		  1 = /dev/ttyW1	Second IO8+ port, first card
		    ...
		  8 = /dev/ttyW8	First IO8+ port, second card
		    ...

 75 block	Compaq Intelligent Drive Array, fourth controller
		  0 = /dev/ida/c3d0	First logical drive whole disk
		 16 = /dev/ida/c3d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c3d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

 76 char	Specialix IO8+ serial card - alternate devices
		  0 = /dev/cuw0		Callout device for ttyW0
		  1 = /dev/cuw1		Callout device for ttyW1
		    ...
		  8 = /dev/cuw8		Callout device for ttyW8
		    ...

 76 block	Compaq Intelligent Drive Array, fifth controller
		  0 = /dev/ida/c4d0	First logical drive whole disk
		 16 = /dev/ida/c4d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c4d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.


 77 char	ComScire Quantum Noise Generator
		  0 = /dev/qng		ComScire Quantum Noise Generator

 77 block	Compaq Intelligent Drive Array, sixth controller
		  0 = /dev/ida/c5d0	First logical drive whole disk
		 16 = /dev/ida/c5d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c5d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.


 78 char	PAM Software's multimodem boards
		  0 = /dev/ttyM0	First PAM modem
		  1 = /dev/ttyM1	Second PAM modem
		    ...

 78 block	Compaq Intelligent Drive Array, seventh controller
		  0 = /dev/ida/c6d0	First logical drive whole disk
		 16 = /dev/ida/c6d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c6d15	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.


 79 char	PAM Software's multimodem boards - alternate devices
		  0 = /dev/cum0		Callout device for ttyM0
		  1 = /dev/cum1		Callout device for ttyM1
		    ...

 79 block	Compaq Intelligent Drive Array, eigth controller
		  0 = /dev/ida/c7d0	First logical drive whole disk
		 16 = /dev/ida/c7d1	Second logical drive whole disk
		    ...
		240 = /dev/ida/c715	16th logical drive whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.


 80 char	Photometrics AT200 CCD camera
		  0 = /dev/at200	Photometrics AT200 CCD camera

 80 block	I2O hard disk
		  0 = /dev/i2o/hda	First I2O hard disk, whole disk
		 16 = /dev/i2o/hdb	Second I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdp	16th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 81 char	video4linux
		  0 = /dev/video0	Video capture/overlay device
		    ...
		 63 = /dev/video63	Video capture/overlay device
		 64 = /dev/radio0	Radio device
		    ...
		127 = /dev/radio63	Radio device
		192 = /dev/vtx0		Teletext device
		    ...
		223 = /dev/vtx31	Teletext device
		224 = /dev/vbi0		Vertical blank interrupt
		    ...
		255 = /dev/vbi31	Vertical blank interrupt

 81 block	I2O hard disk
		  0 = /dev/i2o/hdq	17th I2O hard disk, whole disk
		 16 = /dev/i2o/hdr	18th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdaf	32nd I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 82 char	WiNRADiO communications receiver card
		  0 = /dev/winradio0	First WiNRADiO card
		  1 = /dev/winradio1	Second WiNRADiO card
		    ...

		The driver and documentation may be obtained from
		http://www.proximity.com.au/~brian/winradio/

 82 block	I2O hard disk
		  0 = /dev/i2o/hdag	33rd I2O hard disk, whole disk
		 16 = /dev/i2o/hdah	34th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdav	48th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 83 char	Matrox mga_vid video driver 
 		 0 = /dev/mga_vid0	1st video card
		 1 = /dev/mga_vid1	2nd video card
		 2 = /dev/mga_vid2	3rd video card
		  ...
	        15 = /dev/mga_vid15	16th video card

 83 block	I2O hard disk
		  0 = /dev/i2o/hdaw	49th I2O hard disk, whole disk
		 16 = /dev/i2o/hdax	50th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdbl	64th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 84 char	Ikon 1011[57] Versatec Greensheet Interface
		  0 = /dev/ihcp0	First Greensheet port
		  1 = /dev/ihcp1	Second Greensheet port

 84 block	I2O hard disk
		  0 = /dev/i2o/hdbm	65th I2O hard disk, whole disk
		 16 = /dev/i2o/hdbn	66th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdcb	80th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 85 char	Linux/SGI shared memory input queue
		  0 = /dev/shmiq	Master shared input queue
		  1 = /dev/qcntl0	First device pushed
		  2 = /dev/qcntl1	Second device pushed
		    ...

 85 block	I2O hard disk
		  0 = /dev/i2o/hdcc	81st I2O hard disk, whole disk
		 16 = /dev/i2o/hdcd	82nd I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hdcr	96th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 86 char	SCSI media changer
		  0 = /dev/sch0		First SCSI media changer
		  1 = /dev/sch1		Second SCSI media changer
		    ...

 86 block	I2O hard disk
		  0 = /dev/i2o/hdcs	97th I2O hard disk, whole disk
		 16 = /dev/i2o/hdct	98th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hddh	112th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 87 char	Sony Control-A1 stereo control bus
		  0 = /dev/controla0	First device on chain
		  1 = /dev/controla1	Second device on chain
		    ...

 87 block	I2O hard disk
		  0 = /dev/i2o/hddi	113rd I2O hard disk, whole disk
		 16 = /dev/i2o/hddj	114th I2O hard disk, whole disk
		    ...
		240 = /dev/i2o/hddx	128th I2O hard disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 88 char	COMX synchronous serial card
		  0 = /dev/comx0	COMX channel 0
		  1 = /dev/comx1	COMX channel 1
		    ...

 88 block	Seventh IDE hard disk/CD-ROM interface
		  0 = /dev/hdm		Master: whole disk (or CD-ROM)
		 64 = /dev/hdn		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 89 char	I2C bus interface
		  0 = /dev/i2c-0	First I2C adapter
		  1 = /dev/i2c-1	Second I2C adapter
		    ...

 89 block	Eighth IDE hard disk/CD-ROM interface
		  0 = /dev/hdo		Master: whole disk (or CD-ROM)
		 64 = /dev/hdp		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 90 char	Memory Technology Device (RAM, ROM, Flash)
		  0 = /dev/mtd0		First MTD (rw)
		  1 = /dev/mtdr0	First MTD (ro)
		    ...
		 30 = /dev/mtd15	16th MTD (rw)
		 31 = /dev/mtdr15	16th MTD (ro)

 90 block	Ninth IDE hard disk/CD-ROM interface
		  0 = /dev/hdq		Master: whole disk (or CD-ROM)
		 64 = /dev/hdr		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 91 char	CAN-Bus devices
		  0 = /dev/can0		First CAN-Bus controller
		  1 = /dev/can1		Second CAN-Bus controller
		    ...

 91 block	Tenth IDE hard disk/CD-ROM interface
		  0 = /dev/hds		Master: whole disk (or CD-ROM)
		 64 = /dev/hdt		Slave: whole disk (or CD-ROM)

		Partitions are handled the same way as for the first
		interface (see major number 3).

 92 char	Reserved for ith Kommunikationstechnik MIC ISDN card

 92 block	PPDD encrypted disk driver
		  0 = /dev/ppdd0	First encrypted disk
		  1 = /dev/ppdd1	Second encrypted disk
		    ...

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

 93 char	IBM Smart Capture Card frame grabber {2.6}
		  0 = /dev/iscc0	First Smart Capture Card
		  1 = /dev/iscc1	Second Smart Capture Card
		    ...
		128 = /dev/isccctl0	First Smart Capture Card control
		129 = /dev/isccctl1	Second Smart Capture Card control
		    ...

 93 block	NAND Flash Translation Layer filesystem
		  0 = /dev/nftla	First NFTL layer
		 16 = /dev/nftlb	Second NFTL layer
		    ...
		240 = /dev/nftlp	16th NTFL layer

 94 char	miroVIDEO DC10/30 capture/playback device {2.6}
		  0 = /dev/dcxx0	First capture card
		  1 = /dev/dcxx1	Second capture card
		    ...

 94 block IBM S/390 DASD block storage
    		  0 = /dev/dasda First DASD device, major
    		  1 = /dev/dasda1 First DASD device, block 1
	    	  2 = /dev/dasda2 First DASD device, block 2
    		  3 = /dev/dasda3 First DASD device, block 3
    		  4 = /dev/dasdb Second DASD device, major
    		  5 = /dev/dasdb1 Second DASD device, block 1
    		  6 = /dev/dasdb2 Second DASD device, block 2
    		  7 = /dev/dasdb3 Second DASD device, block 3
		    ...

 95 char	IP filter
		  0 = /dev/ipl		Filter control device/log file
		  1 = /dev/ipnat	NAT control device/log file
		  2 = /dev/ipstate	State information log file
		  3 = /dev/ipauth	Authentication control device/log file
		    ...		

 96 char	Parallel port ATAPI tape devices
		  0 = /dev/pt0		First parallel port ATAPI tape
		  1 = /dev/pt1		Second parallel port ATAPI tape
		    ...
		128 = /dev/npt0		First p.p. ATAPI tape, no rewind
		129 = /dev/npt1		Second p.p. ATAPI tape, no rewind
		    ...

 96 block Inverse NAND Flash Translation Layer
		  0 = /dev/inftla First INFTL layer
		 16 = /dev/inftlb Second INFTL layer
		    ...
		240 = /dev/inftlp	16th INTFL layer

 97 char	Parallel port generic ATAPI interface
		  0 = /dev/pg0		First parallel port ATAPI device
		  1 = /dev/pg1		Second parallel port ATAPI device
		  2 = /dev/pg2		Third parallel port ATAPI device
		  3 = /dev/pg3		Fourth parallel port ATAPI device

		These devices support the same API as the generic SCSI
		devices.

 97 block	Packet writing for CD/DVD devices
		  0 = /dev/pktcdvd0	First packet-writing module
		  1 = /dev/pktcdvd1	Second packet-writing module
		    ...

 98 char	Control and Measurement Device (comedi)
		  0 = /dev/comedi0	First comedi device
		  1 = /dev/comedi1	Second comedi device
		    ...

		See http://stm.lbl.gov/comedi or http://www.llp.fu-berlin.de/.

 98 block	User-mode virtual block device
		  0 = /dev/ubda		First user-mode block device
		 16 = /dev/udbb		Second user-mode block device
		    ...
		
		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

		This device is used by the user-mode virtual kernel port.

 99 char	Raw parallel ports
		  0 = /dev/parport0	First parallel port
		  1 = /dev/parport1	Second parallel port
		    ...

 99 block	JavaStation flash disk
		  0 = /dev/jsfd		JavaStation flash disk

100 char	Telephony for Linux
		  0 = /dev/phone0	First telephony device
		  1 = /dev/phone1	Second telephony device
		    ...

101 char	Motorola DSP 56xxx board
		  0 = /dev/mdspstat	Status information
		  1 = /dev/mdsp1	First DSP board I/O controls
		    ...
		 16 = /dev/mdsp16	16th DSP board I/O controls

101 block	AMI HyperDisk RAID controller
		  0 = /dev/amiraid/ar0	First array whole disk
		 16 = /dev/amiraid/ar1	Second array whole disk
		    ...
		240 = /dev/amiraid/ar15	16th array whole disk

		For each device, partitions are added as:
		  0 = /dev/amiraid/ar?	  Whole disk
		  1 = /dev/amiraid/ar?p1  First partition
		  2 = /dev/amiraid/ar?p2  Second partition
		    ...
		 15 = /dev/amiraid/ar?p15 15th partition

102 char	Philips SAA5249 Teletext signal decoder {2.6}
		  0 = /dev/tlk0		First Teletext decoder
		  1 = /dev/tlk1		Second Teletext decoder
		  2 = /dev/tlk2		Third Teletext decoder
		  3 = /dev/tlk3		Fourth Teletext decoder

102 block	Compressed block device
		  0 = /dev/cbd/a	First compressed block device, whole device
		 16 = /dev/cbd/b	Second compressed block device, whole device
		    ...
		240 = /dev/cbd/p	16th compressed block device, whole device

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

103 char	Arla network file system
		  0 = /dev/nnpfs0	First NNPFS device
		  1 = /dev/nnpfs1	Second NNPFS device

		Arla is a free clone of the Andrew File System, AFS.
		The NNPFS device gives user mode filesystem
		implementations a kernel presence for caching and easy
		mounting.  For more information about the project,
		write to <arla-drinkers@stacken.kth.se> or see
		http://www.stacken.kth.se/project/arla/

103 block	Audit device
		  0 = /dev/audit	Audit device

104 char	Flash BIOS support

104 block	Compaq Next Generation Drive Array, first controller
		  0 = /dev/cciss/c0d0	First logical drive, whole disk
		 16 = /dev/cciss/c0d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c0d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

105 char	Comtrol VS-1000 serial controller
		  0 = /dev/ttyV0	First VS-1000 port
		  1 = /dev/ttyV1	Second VS-1000 port
		    ...

105 block	Compaq Next Generation Drive Array, second controller
		  0 = /dev/cciss/c1d0	First logical drive, whole disk
		 16 = /dev/cciss/c1d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c1d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

106 char	Comtrol VS-1000 serial controller - alternate devices
		  0 = /dev/cuv0		First VS-1000 port
		  1 = /dev/cuv1		Second VS-1000 port
		    ...

106 block	Compaq Next Generation Drive Array, third controller
		  0 = /dev/cciss/c2d0	First logical drive, whole disk
		 16 = /dev/cciss/c2d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c2d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

107 char	3Dfx Voodoo Graphics device
		  0 = /dev/3dfx		Primary 3Dfx graphics device

107 block	Compaq Next Generation Drive Array, fourth controller
		  0 = /dev/cciss/c3d0	First logical drive, whole disk
		 16 = /dev/cciss/c3d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c3d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

108 char	Device independent PPP interface
		  0 = /dev/ppp		Device independent PPP interface

108 block	Compaq Next Generation Drive Array, fifth controller
		  0 = /dev/cciss/c4d0	First logical drive, whole disk
		 16 = /dev/cciss/c4d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c4d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

109 char	Reserved for logical volume manager

109 block	Compaq Next Generation Drive Array, sixth controller
		  0 = /dev/cciss/c5d0	First logical drive, whole disk
		 16 = /dev/cciss/c5d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c5d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

110 char	miroMEDIA Surround board
		  0 = /dev/srnd0	First miroMEDIA Surround board
		  1 = /dev/srnd1	Second miroMEDIA Surround board
		    ...

110 block	Compaq Next Generation Drive Array, seventh controller
		  0 = /dev/cciss/c6d0	First logical drive, whole disk
		 16 = /dev/cciss/c6d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c6d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

111 char	Philips SAA7146-based audio/video card {2.6}
		  0 = /dev/av0		First A/V card
		  1 = /dev/av1		Second A/V card
		    ...

111 block	Compaq Next Generation Drive Array, eigth controller
		  0 = /dev/cciss/c7d0	First logical drive, whole disk
		 16 = /dev/cciss/c7d1	Second logical drive, whole disk
		    ...
		240 = /dev/cciss/c7d15	16th logical drive, whole disk

		Partitions are handled the same way as for Mylex
		DAC960 (see major number 48) except that the limit on
		partitions is 15.

112 char	ISI serial card
		  0 = /dev/ttyM0	First ISI port
		  1 = /dev/ttyM1	Second ISI port
		    ...

		There is currently a device-naming conflict between
		these and PAM multimodems (major 78).

112 block	IBM iSeries virtual disk
		  0 = /dev/iseries/vda	First virtual disk, whole disk
		  8 = /dev/iseries/vdb	Second virtual disk, whole disk
		    ...
		200 = /dev/iseries/vdz	26th virtual disk, whole disk
		208 = /dev/iseries/vdaa	27th virtual disk, whole disk
		    ...
		248 = /dev/iseries/vdaf	32nd virtual disk, whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 7.

113 char	ISI serial card - alternate devices
		  0 = /dev/cum0		Callout device for ttyM0
		  1 = /dev/cum1		Callout device for ttyM1
		    ...

113 block	IBM iSeries virtual CD-ROM

		  0 = /dev/iseries/vcda	First virtual CD-ROM
		  1 = /dev/iseries/vcdb	Second virtual CD-ROM
		    ...

114 char	Picture Elements ISE board
		  0 = /dev/ise0		First ISE board
		  1 = /dev/ise1		Second ISE board
		    ...
		128 = /dev/isex0	Control node for first ISE board
		129 = /dev/isex1	Control node for second ISE board
		    ...

		The ISE board is an embedded computer, optimized for
		image processing. The /dev/iseN nodes are the general
		I/O access to the board, the /dev/isex0 nodes command
		nodes used to control the board.

114 block       IDE BIOS powered software RAID interfaces such as the
                Promise Fastrak

                  0 = /dev/ataraid/d0
                  1 = /dev/ataraid/d0p1
                  2 = /dev/ataraid/d0p2
                  ...
                 16 = /dev/ataraid/d1
                 17 = /dev/ataraid/d1p1
                 18 = /dev/ataraid/d1p2
                  ...
                255 = /dev/ataraid/d15p15

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

115 char	TI link cable devices (115 was formerly the console driver speaker)
		  0 = /dev/tipar0    Parallel cable on first parallel port
		  ...
		  7 = /dev/tipar7    Parallel cable on seventh parallel port

		  8 = /dev/tiser0    Serial cable on first serial port
		  ...
		 15 = /dev/tiser7    Serial cable on seventh serial port

		 16 = /dev/tiusb0    First USB cable
		  ...
		 47 = /dev/tiusb31   32nd USB cable

115 block       NetWare (NWFS) Devices (0-255)

                The NWFS (NetWare) devices are used to present a
                collection of NetWare Mirror Groups or NetWare
                Partitions as a logical storage segment for
                use in mounting NetWare volumes.  A maximum of
                256 NetWare volumes can be supported in a single
                machine.

                http://www.kernel.org/pub/linux/kernel/people/jmerkey/nwfs

                0 = /dev/nwfs/v0    First NetWare (NWFS) Logical Volume
                1 = /dev/nwfs/v1    Second NetWare (NWFS) Logical Volume
                2 = /dev/nwfs/v2    Third NetWare (NWFS) Logical Volume
                      ...
                255 = /dev/nwfs/v255    Last NetWare (NWFS) Logical Volume

116 char	Advanced Linux Sound Driver (ALSA)

116 block       MicroMemory battery backed RAM adapter (NVRAM)
                Supports 16 boards, 15 paritions each.
                Requested by neilb at cse.unsw.edu.au.

		 0 = /dev/umem/d0      Whole of first board
		 1 = /dev/umem/d0p1    First partition of first board
		 2 = /dev/umem/d0p2    Second partition of first board
		15 = /dev/umem/d0p15   15th partition of first board

		16 = /dev/umem/d1      Whole of second board
		17 = /dev/umem/d1p1    First partition of second board
		    ...
		255= /dev/umem/d15p15  15th partition of 16th board.

117 char	COSA/SRP synchronous serial card
		  0 = /dev/cosa0c0	1st board, 1st channel
		  1 = /dev/cosa0c1	1st board, 2nd channel
		    ...
		 16 = /dev/cosa1c0	2nd board, 1st channel
		 17 = /dev/cosa1c1	2nd board, 2nd channel
		    ...

117 block       Enterprise Volume Management System (EVMS)

                The EVMS driver uses a layered, plug-in model to provide
                unparalleled flexibility and extensibility in managing
                storage.  This allows for easy expansion or customization
                of various levels of volume management.  Requested by
                Mark Peloquin (peloquin at us.ibm.com).

                Note: EVMS populates and manages all the devnodes in
                /dev/evms.

                http://sf.net/projects/evms

                  0 = /dev/evms/block_device   EVMS block device
                  1 = /dev/evms/legacyname1    First EVMS legacy device
                  2 = /dev/evms/legacyname2    Second EVMS legacy device
                    ...
                    Both ranges can grow (down or up) until they meet.
                    ...
                254 = /dev/evms/EVMSname2      Second EVMS native device
                255 = /dev/evms/EVMSname1      First EVMS native device

                Note: legacyname(s) are derived from the normal legacy
                device names.  For example, /dev/hda5 would become
                /dev/evms/hda5.

118 char	IBM Cryptographic Accelerator
		  0 = /dev/ica	Virtual interface to all IBM Crypto Accelerators
		  1 = /dev/ica0	IBMCA Device 0
		  2 = /dev/ica1	IBMCA Device 1
		    ...

119 char	VMware virtual network control
		  0 = /dev/vnet0	1st virtual network
		  1 = /dev/vnet1	2nd virtual network
		    ...

120-127 char	LOCAL/EXPERIMENTAL USE
120-127 block	LOCAL/EXPERIMENTAL USE
		Allocated for local/experimental use.  For devices not
		assigned official numbers, these ranges should be
		used in order to avoid conflicting with future assignments.

128-135 char	Unix98 PTY masters

		These devices should not have corresponding device
		nodes; instead they should be accessed through the
		/dev/ptmx cloning interface.


128 block       SCSI disk devices (128-143)
                  0 = /dev/sddy         129th SCSI disk whole disk
                 16 = /dev/sddz         130th SCSI disk whole disk
                 32 = /dev/sdea         131th SCSI disk whole disk
                    ...
                240 = /dev/sden         144th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


129 block       SCSI disk devices (144-159)
                  0 = /dev/sdeo         145th SCSI disk whole disk
                 16 = /dev/sdep         146th SCSI disk whole disk
                 32 = /dev/sdeq         147th SCSI disk whole disk
                    ...
                240 = /dev/sdfd         160th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

130 char 	(Misc devices)

130 block       SCSI disk devices (160-175)
                  0 = /dev/sdfe         161st SCSI disk whole disk
                 16 = /dev/sdff         162nd SCSI disk whole disk
                 32 = /dev/sdfg         163rd SCSI disk whole disk
                    ...
                240 = /dev/sdft         176th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

131 block       SCSI disk devices (176-191)
                  0 = /dev/sdfu         177th SCSI disk whole disk
                 16 = /dev/sdfv         178th SCSI disk whole disk
                 32 = /dev/sdfw         179th SCSI disk whole disk
                    ...
                240 = /dev/sdgj         192nd SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


132 block       SCSI disk devices (192-207)
                  0 = /dev/sdgk         193rd SCSI disk whole disk
                 16 = /dev/sdgl         194th SCSI disk whole disk
                 32 = /dev/sdgm         195th SCSI disk whole disk
                    ...
                240 = /dev/sdgz         208th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


133 block       SCSI disk devices (208-223)
                  0 = /dev/sdha         209th SCSI disk whole disk
                 16 = /dev/sdhb         210th SCSI disk whole disk
                 32 = /dev/sdhc         211th SCSI disk whole disk
                    ...
                240 = /dev/sdhp         224th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


134 block       SCSI disk devices (224-239)
                  0 = /dev/sdhq         225th SCSI disk whole disk
                 16 = /dev/sdhr         226th SCSI disk whole disk
                 32 = /dev/sdhs         227th SCSI disk whole disk
                    ...
                240 = /dev/sdif         240th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


135 block       SCSI disk devices (240-255)
                  0 = /dev/sdig         241st SCSI disk whole disk
                 16 = /dev/sdih         242nd SCSI disk whole disk
                 32 = /dev/sdih         243rd SCSI disk whole disk
                    ...
                240 = /dev/sdiv         256th SCSI disk whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.


136-143 char	Unix98 PTY slaves
		  0 = /dev/pts/0	First Unix98 pseudo-TTY
		  1 = /dev/pts/1	Second Unix98 pesudo-TTY
		    ...

		These device nodes are automatically generated with
		the proper permissions and modes by mounting the
		devpts filesystem onto /dev/pts with the appropriate
		mount options (distribution dependent, however, on
		*most* distributions the appropriate options are
		"mode=0620,gid=<gid of the "tty" group>".)

136 block	Mylex DAC960 PCI RAID controller; ninth controller
		  0 = /dev/rd/c8d0	First disk, whole disk
		  8 = /dev/rd/c8d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c8d31	32nd disk, whole disk

		Partitions are handled as for major 48.

137 block	Mylex DAC960 PCI RAID controller; tenth controller
		  0 = /dev/rd/c9d0	First disk, whole disk
		  8 = /dev/rd/c9d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c9d31	32nd disk, whole disk

		Partitions are handled as for major 48.

138 block	Mylex DAC960 PCI RAID controller; eleventh controller
		  0 = /dev/rd/c10d0	First disk, whole disk
		  8 = /dev/rd/c10d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c10d31	32nd disk, whole disk

		Partitions are handled as for major 48.

139 block	Mylex DAC960 PCI RAID controller; twelfth controller
		  0 = /dev/rd/c11d0	First disk, whole disk
		  8 = /dev/rd/c11d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c11d31	32nd disk, whole disk

		Partitions are handled as for major 48.

140 block	Mylex DAC960 PCI RAID controller; thirteenth controller
		  0 = /dev/rd/c12d0	First disk, whole disk
		  8 = /dev/rd/c12d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c12d31	32nd disk, whole disk

		Partitions are handled as for major 48.

141 block	Mylex DAC960 PCI RAID controller; fourteenth controller
		  0 = /dev/rd/c13d0	First disk, whole disk
		  8 = /dev/rd/c13d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c13d31	32nd disk, whole disk

		Partitions are handled as for major 48.

142 block	Mylex DAC960 PCI RAID controller; fifteenth controller
		  0 = /dev/rd/c14d0	First disk, whole disk
		  8 = /dev/rd/c14d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c14d31	32nd disk, whole disk

		Partitions are handled as for major 48.

143 block	Mylex DAC960 PCI RAID controller; sixteenth controller
		  0 = /dev/rd/c15d0	First disk, whole disk
		  8 = /dev/rd/c15d1	Second disk, whole disk
		    ...
		248 = /dev/rd/c15d31	32nd disk, whole disk

		Partitions are handled as for major 48.

144 char	Encapsulated PPP
		  0 = /dev/pppox0	First PPP over Ethernet
		    ...
		 63 = /dev/pppox63	64th PPP over Ethernet

		This is primarily used for ADSL.

		The SST 5136-DN DeviceNet interface driver has been
		relocated to major 183 due to an unfortunate conflict.

144 block	Expansion Area #1 for more non-device (e.g. NFS) mounts
		  0 = mounted device 256
		255 = mounted device 511

145 char	SAM9407-based soundcard
		  0 = /dev/sam0_mixer
		  1 = /dev/sam0_sequencer
		  2 = /dev/sam0_midi00
		  3 = /dev/sam0_dsp
		  4 = /dev/sam0_audio
		  6 = /dev/sam0_sndstat
		 18 = /dev/sam0_midi01
		 34 = /dev/sam0_midi02
		 50 = /dev/sam0_midi03
		 64 = /dev/sam1_mixer
		    ...
		128 = /dev/sam2_mixer
		    ...
		192 = /dev/sam3_mixer
		    ...

		Device functions match OSS, but offer a number of
		addons, which are sam9407 specific.  OSS can be
		operated simultaneously, taking care of the codec.

145 block	Expansion Area #2 for more non-device (e.g. NFS) mounts
		  0 = mounted device 512
		255 = mounted device 767

146 char	SYSTRAM SCRAMNet mirrored-memory network
		  0 = /dev/scramnet0	First SCRAMNet device
		  1 = /dev/scramnet1	Second SCRAMNet device
		    ...

146 block	Expansion Area #3 for more non-device (e.g. NFS) mounts
		  0 = mounted device 768
		255 = mounted device 1023

147 char	Aureal Semiconductor Vortex Audio device
		  0 = /dev/aureal0	First Aureal Vortex
		  1 = /dev/aureal1	Second Aureal Vortex
		    ...

147 block	Distributed Replicated Block Device (DRBD)
		  0 = /dev/drbd0	First DRBD device
		  1 = /dev/drbd1	Second DRBD device
		    ...
		
148 char	Technology Concepts serial card
		  0 = /dev/ttyT0	First TCL port
		  1 = /dev/ttyT1	Second TCL port
		    ...

149 char	Technology Concepts serial card - alternate devices
		  0 = /dev/cut0		Callout device for ttyT0
		  1 = /dev/cut0		Callout device for ttyT1
		    ...

150 char	Real-Time Linux FIFOs
		  0 = /dev/rtf0		First RTLinux FIFO
		  1 = /dev/rtf1		Second RTLinux FIFO
		    ...

151 char	DPT I2O SmartRaid V controller
		  0 = /dev/dpti0	First DPT I2O adapter
		  1 = /dev/dpti1	Second DPT I2O adapter
		    ...

152 char	EtherDrive Control Device
		  0 = /dev/etherd/ctl	Connect/Disconnect an EtherDrive
		  1 = /dev/etherd/err	Monitor errors
		  2 = /dev/etherd/raw	Raw AoE packet monitor

152 block	EtherDrive Block Devices
		  0 = /dev/etherd/0	EtherDrive 0
		    ...
		255 = /dev/etherd/255	EtherDrive 255

153 char	SPI Bus Interface (sometimes referred to as MicroWire)
		  0 = /dev/spi0		First SPI device on the bus
		  1 = /dev/spi1		Second SPI device on the bus
		    ...
		 15 = /dev/spi15	Sixteenth SPI device on the bus

153 block	Enhanced Metadisk RAID (EMD) storage units
		  0 = /dev/emd/0	First unit
		  1 = /dev/emd/0p1	Partition 1 on First unit
		  2 = /dev/emd/0p2	Partition 2 on First unit
		    ...
		 15 = /dev/emd/0p15	Partition 15 on First unit

		 16 = /dev/emd/1	Second unit
		 32 = /dev/emd/2	Third unit
		    ...
		240 = /dev/emd/15	Sixteenth unit

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 15.

154 char	Specialix RIO serial card
		  0 = /dev/ttySR0	First RIO port
		    ...
		255 = /dev/ttySR255	256th RIO port

155 char	Specialix RIO serial card - alternate devices
		  0 = /dev/cusr0	Callout device for ttySR0
		    ...
		255 = /dev/cusr255	Callout device for ttySR255

156 char	Specialix RIO serial card
		  0 = /dev/ttySR256	257th RIO port
		    ...
		255 = /dev/ttySR511	512th RIO port

157 char	Specialix RIO serial card - alternate devices
		  0 = /dev/cusr256	Callout device for ttySR256
		    ...
		255 = /dev/cusr511	Callout device for ttySR511

158 char	Dialogic GammaLink fax driver
		  0 = /dev/gfax0	GammaLink channel 0
		  1 = /dev/gfax1	GammaLink channel 1
		    ...

159 char	RESERVED
159 block	RESERVED

160 char	General Purpose Instrument Bus (GPIB)
		  0 = /dev/gpib0	First GPIB bus
		  1 = /dev/gpib1	Second GPIB bus
		    ...

160 block       Carmel 8-port SATA Disks on First Controller
		  0 = /dev/carmel/0     SATA disk 0 whole disk
		  1 = /dev/carmel/0p1   SATA disk 0 partition 1
		    ...
		 31 = /dev/carmel/0p31  SATA disk 0 partition 31

		 32 = /dev/carmel/1     SATA disk 1 whole disk
		 64 = /dev/carmel/2     SATA disk 2 whole disk
		    ...
		224 = /dev/carmel/7     SATA disk 7 whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 31.

161 char	IrCOMM devices (IrDA serial/parallel emulation)
		  0 = /dev/ircomm0	First IrCOMM device
		  1 = /dev/ircomm1	Second IrCOMM device
		    ...
		 16 = /dev/irlpt0	First IrLPT device
		 17 = /dev/irlpt1	Second IrLPT device
		    ...

161 block       Carmel 8-port SATA Disks on Second Controller
		  0 = /dev/carmel/8     SATA disk 8 whole disk
		  1 = /dev/carmel/8p1   SATA disk 8 partition 1
		    ...
		 31 = /dev/carmel/8p31  SATA disk 8 partition 31

		 32 = /dev/carmel/9     SATA disk 9 whole disk
		 64 = /dev/carmel/10    SATA disk 10 whole disk
		    ...
		224 = /dev/carmel/15    SATA disk 15 whole disk

		Partitions are handled in the same way as for IDE
		disks (see major number 3) except that the limit on
		partitions is 31. 

162 char	Raw block device interface
		  0 = /dev/rawctl	Raw I/O control device
		  1 = /dev/raw/raw1	First raw I/O device
		  2 = /dev/raw/raw2	Second raw I/O device
		    ...

163 char	UNASSIGNED (was Radio Tech BIM-XXX-RS232 radio modem - see 51)

164 char	Chase Research AT/PCI-Fast serial card
		  0 = /dev/ttyCH0	AT/PCI-Fast board 0, port 0
		    ...
		 15 = /dev/ttyCH15	AT/PCI-Fast board 0, port 15
		 16 = /dev/ttyCH16	AT/PCI-Fast board 1, port 0
		    ...
		 31 = /dev/ttyCH31	AT/PCI-Fast board 1, port 15
		 32 = /dev/ttyCH32	AT/PCI-Fast board 2, port 0
		    ...
		 47 = /dev/ttyCH47	AT/PCI-Fast board 2, port 15
		 48 = /dev/ttyCH48	AT/PCI-Fast board 3, port 0
		    ...
		 63 = /dev/ttyCH63	AT/PCI-Fast board 3, port 15

165 char	Chase Research AT/PCI-Fast serial card - alternate devices
		  0 = /dev/cuch0	Callout device for ttyCH0
		    ...
		 63 = /dev/cuch63	Callout device for ttyCH63

166 char	ACM USB modems
		  0 = /dev/ttyACM0	First ACM modem
		  1 = /dev/ttyACM1	Second ACM modem
		    ...

167 char	ACM USB modems - alternate devices
		  0 = /dev/cuacm0	Callout device for ttyACM0
		  1 = /dev/cuacm1	Callout device for ttyACM1
		    ...

168 char	Eracom CSA7000 PCI encryption adaptor
		  0 = /dev/ecsa0	First CSA7000
		  1 = /dev/ecsa1	Second CSA7000
		    ...

169 char	Eracom CSA8000 PCI encryption adaptor
		  0 = /dev/ecsa8-0	First CSA8000
		  1 = /dev/ecsa8-1	Second CSA8000
		    ...

170 char	AMI MegaRAC remote access controller
		  0 = /dev/megarac0	First MegaRAC card
		  1 = /dev/megarac1	Second MegaRAC card
		    ...

171 char	Reserved for IEEE 1394 (Firewire)


172 char	Moxa Intellio serial card
		  0 = /dev/ttyMX0	First Moxa port
		  1 = /dev/ttyMX1	Second Moxa port
		    ...
		127 = /dev/ttyMX127	128th Moxa port
		128 = /dev/moxactl	Moxa control port

173 char	Moxa Intellio serial card - alternate devices
		  0 = /dev/cumx0	Callout device for ttyMX0
		  1 = /dev/cumx1	Callout device for ttyMX1
		    ...
		127 = /dev/cumx127	Callout device for ttyMX127

174 char	SmartIO serial card
		  0 = /dev/ttySI0	First SmartIO port
		  1 = /dev/ttySI1	Second SmartIO port
		    ...

175 char	SmartIO serial card - alternate devices
		  0 = /dev/cusi0	Callout device for ttySI0
		  1 = /dev/cusi1	Callout device for ttySI1
		    ...

176 char	nCipher nFast PCI crypto accelerator
		  0 = /dev/nfastpci0	First nFast PCI device
		  1 = /dev/nfastpci1	First nFast PCI device
		    ...

177 char	TI PCILynx memory spaces
		  0 = /dev/pcilynx/aux0	 AUX space of first PCILynx card
		    ...
		 15 = /dev/pcilynx/aux15 AUX space of 16th PCILynx card
		 16 = /dev/pcilynx/rom0	 ROM space of first PCILynx card
		    ...
		 31 = /dev/pcilynx/rom15 ROM space of 16th PCILynx card
		 32 = /dev/pcilynx/ram0	 RAM space of first PCILynx card
		    ...
		 47 = /dev/pcilynx/ram15 RAM space of 16th PCILynx card

178 char	Giganet cLAN1xxx virtual interface adapter
		  0 = /dev/clanvi0	First cLAN adapter
		  1 = /dev/clanvi1	Second cLAN adapter
		    ...

179 char	CCube DVXChip-based PCI products
		  0 = /dev/dvxirq0	First DVX device
		  1 = /dev/dvxirq1	Second DVX device
		    ...

180 char	USB devices
		  0 = /dev/usb/lp0	First USB printer
		    ...
		 15 = /dev/usb/lp15	16th USB printer
		 16 = /dev/usb/mouse0	First USB mouse
		    ...
		 31 = /dev/usb/mouse15	16th USB mouse
		 32 = /dev/usb/ez0	First USB firmware loader
		    ...
		 47 = /dev/usb/ez15	16th USB firmware loader
		 48 = /dev/usb/scanner0	First USB scanner
		    ...
		 63 = /dev/usb/scanner15 16th USB scanner
		 64 = /dev/usb/rio500	Diamond Rio 500
		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)

180 block	USB block devices
		0 = /dev/uba		First USB block device
		8 = /dev/ubb		Second USB block device
		16 = /dev/ubc		Thrid USB block device
		...

181 char	Conrad Electronic parallel port radio clocks
		  0 = /dev/pcfclock0	First Conrad radio clock
		  1 = /dev/pcfclock1	Second Conrad radio clock
		    ...

182 char	Picture Elements THR2 binarizer
		  0 = /dev/pethr0	First THR2 board
		  1 = /dev/pethr1	Second THR2 board
		    ...

183 char	SST 5136-DN DeviceNet interface
		  0 = /dev/ss5136dn0	First DeviceNet interface
		  1 = /dev/ss5136dn1	Second DeviceNet interface
		    ...

		This device used to be assigned to major number 144.
		It had to be moved due to an unfortunate conflict.

184 char	Picture Elements' video simulator/sender
		  0 = /dev/pevss0	First sender board
		  1 = /dev/pevss1	Second sender board
		    ...

185 char	InterMezzo high availability file system
		  0 = /dev/intermezzo0	First cache manager
		  1 = /dev/intermezzo1	Second cache manager
		    ...

		See http://www.inter-mezzo.org/ for more information.

186 char	Object-based storage control device
		  0 = /dev/obd0		First obd control device
		  1 = /dev/obd1		Second obd control device
		    ...

		See ftp://ftp.lustre.org/pub/obd for code and information.

187 char	DESkey hardware encryption device
		  0 = /dev/deskey0	First DES key
		  1 = /dev/deskey1	Second DES key
		    ...

188 char	USB serial converters
		  0 = /dev/ttyUSB0	First USB serial converter
		  1 = /dev/ttyUSB1	Second USB serial converter
		    ...

189 char	USB serial converters - alternate devices
		  0 = /dev/cuusb0	Callout device for ttyUSB0
		  1 = /dev/cuusb1	Callout device for ttyUSB1
		    ...

190 char	Kansas City tracker/tuner card
		  0 = /dev/kctt0	First KCT/T card
		  1 = /dev/kctt1	Second KCT/T card
		    ...

191 char	Reserved for PCMCIA

192 char	Kernel profiling interface
		  0 = /dev/profile	Profiling control device
		  1 = /dev/profile0	Profiling device for CPU 0
		  2 = /dev/profile1	Profiling device for CPU 1
		    ...

193 char	Kernel event-tracing interface
		  0 = /dev/trace	Tracing control device
		  1 = /dev/trace0	Tracing device for CPU 0
		  2 = /dev/trace1	Tracing device for CPU 1
		    ...

194 char	linVideoStreams (LINVS)
		  0 = /dev/mvideo/status0	Video compression status
		  1 = /dev/mvideo/stream0	Video stream
		  2 = /dev/mvideo/frame0	Single compressed frame
		  3 = /dev/mvideo/rawframe0	Raw uncompressed frame
		  4 = /dev/mvideo/codec0	Direct codec access
		  5 = /dev/mvideo/video4linux0	Video4Linux compatibility

		 16 = /dev/mvideo/status1	Second device
		    ...
		 32 = /dev/mvideo/status2	Third device
		    ...
		    ...
		240 = /dev/mvideo/status15	16th device 
		    ...

195 char	Nvidia graphics devices
		  0 = /dev/nvidia0		First Nvidia card
		  1 = /dev/nvidia1		Second Nvidia card
		    ...
		255 = /dev/nvidiactl		Nvidia card control device

196 char	Tormenta T1 card
		  0 = /dev/tor/0		Master control channel for all cards
		  1 = /dev/tor/1		First DS0
		  2 = /dev/tor/2		Second DS0
		    ...
		 48 = /dev/tor/48		48th DS0
		 49 = /dev/tor/49		First pseudo-channel
		 50 = /dev/tor/50		Second pseudo-channel
		    ...

197 char	OpenTNF tracing facility
		  0 = /dev/tnf/t0		Trace 0 data extraction
		  1 = /dev/tnf/t1		Trace 1 data extraction
		    ...
		128 = /dev/tnf/status		Tracing facility status
		130 = /dev/tnf/trace		Tracing device

198 char	Total Impact TPMP2 quad coprocessor PCI card
		  0 = /dev/tpmp2/0		First card
		  1 = /dev/tpmp2/1		Second card
		    ...

199 char	Veritas volume manager (VxVM) volumes
		  0 = /dev/vx/rdsk/*/*		First volume
		  1 = /dev/vx/rdsk/*/*		Second volume
		    ...

199 block	Veritas volume manager (VxVM) volumes
		  0 = /dev/vx/dsk/*/*		First volume
		  1 = /dev/vx/dsk/*/*		Second volume
		    ...

		The namespace in these directories is maintained by
		the user space VxVM software.

200 char	Veritas VxVM configuration interface
                  0 = /dev/vx/config		Configuration access node
                  1 = /dev/vx/trace		Volume i/o trace access node
                  2 = /dev/vx/iod		Volume i/o daemon access node
                  3 = /dev/vx/info		Volume information access node
                  4 = /dev/vx/task		Volume tasks access node
                  5 = /dev/vx/taskmon		Volume tasks monitor daemon

201 char	Veritas VxVM dynamic multipathing driver
		  0 = /dev/vx/rdmp/*		First multipath device
		  1 = /dev/vx/rdmp/*		Second multipath device
		    ...
201 block	Veritas VxVM dynamic multipathing driver
		  0 = /dev/vx/dmp/*		First multipath device
		  1 = /dev/vx/dmp/*		Second multipath device
		    ...

		The namespace in these directories is maintained by
		the user space VxVM software.

202 char	CPU model-specific registers
		  0 = /dev/cpu/0/msr		MSRs on CPU 0
		  1 = /dev/cpu/1/msr		MSRs on CPU 1
		    ...

203 char	CPU CPUID information
		  0 = /dev/cpu/0/cpuid		CPUID on CPU 0
		  1 = /dev/cpu/1/cpuid		CPUID on CPU 1
		    ...

204 char	Low-density serial ports
		  0 = /dev/ttyLU0		LinkUp Systems L72xx UART - port 0
		  1 = /dev/ttyLU1		LinkUp Systems L72xx UART - port 1
		  2 = /dev/ttyLU2		LinkUp Systems L72xx UART - port 2
		  3 = /dev/ttyLU3		LinkUp Systems L72xx UART - port 3
		  4 = /dev/ttyFB0		Intel Footbridge (ARM)
		  5 = /dev/ttySA0		StrongARM builtin serial port 0
		  6 = /dev/ttySA1		StrongARM builtin serial port 1
		  7 = /dev/ttySA2		StrongARM builtin serial port 2
		  8 = /dev/ttySC0		SCI serial port (SuperH) - port 0
		  9 = /dev/ttySC1		SCI serial port (SuperH) - port 1
		 10 = /dev/ttySC2		SCI serial port (SuperH) - port 2
		 11 = /dev/ttySC3		SCI serial port (SuperH) - port 3
		 12 = /dev/ttyFW0		Firmware console - port 0
		 13 = /dev/ttyFW1		Firmware console - port 1
		 14 = /dev/ttyFW2		Firmware console - port 2
		 15 = /dev/ttyFW3		Firmware console - port 3
		 16 = /dev/ttyAM0		ARM "AMBA" serial port 0
		    ...
		 31 = /dev/ttyAM15		ARM "AMBA" serial port 15
		 32 = /dev/ttyDB0		DataBooster serial port 0
		    ...
		 39 = /dev/ttyDB7		DataBooster serial port 7
		 40 = /dev/ttySG0		SGI Altix console port
		 41 = /dev/ttySMX0		Motorola i.MX - port 0
		 42 = /dev/ttySMX1		Motorola i.MX - port 1
		 43 = /dev/ttySMX2		Motorola i.MX - port 2
		 44 = /dev/ttyMM0		Marvell MPSC - port 0
		 45 = /dev/ttyMM1		Marvell MPSC - port 1	
		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
		    ...
		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
		 50 = /dev/ttyIOC40		Altix serial card
		    ...
		 81 = /dev/ttyIOC431		Altix serial card

205 char	Low-density serial ports (alternate device)
		  0 = /dev/culu0		Callout device for ttyLU0
		  1 = /dev/culu1		Callout device for ttyLU1
		  2 = /dev/culu2		Callout device for ttyLU2
		  3 = /dev/culu3		Callout device for ttyLU3
		  4 = /dev/cufb0		Callout device for ttyFB0
		  5 = /dev/cusa0		Callout device for ttySA0
		  6 = /dev/cusa1		Callout device for ttySA1
		  7 = /dev/cusa2		Callout device for ttySA2
		  8 = /dev/cusc0		Callout device for ttySC0
		  9 = /dev/cusc1		Callout device for ttySC1
		 10 = /dev/cusc2		Callout device for ttySC2
		 11 = /dev/cusc3		Callout device for ttySC3
		 12 = /dev/cufw0		Callout device for ttyFW0
		 13 = /dev/cufw1		Callout device for ttyFW1
		 14 = /dev/cufw2		Callout device for ttyFW2
		 15 = /dev/cufw3		Callout device for ttyFW3
		 16 = /dev/cuam0		Callout device for ttyAM0
		    ...
		 31 = /dev/cuam15		Callout device for ttyAM15
		 32 = /dev/cudb0		Callout device for ttyDB0
		    ...
		 39 = /dev/cudb7		Callout device for ttyDB7
		 40 = /dev/cusg0		Callout device for ttySG0
		 41 = /dev/ttycusmx0		Callout device for ttySMX0
		 42 = /dev/ttycusmx1		Callout device for ttySMX1
		 43 = /dev/ttycusmx2		Callout device for ttySMX2
		 46 = /dev/cucpm0		Callout device for ttyCPM0
		    ...
		 49 = /dev/cucpm5		Callout device for ttyCPM5
		 50 = /dev/cuioc40		Callout device for ttyIOC40
		    ...
		 81 = /dev/cuioc431		Callout device for ttyIOC431


206 char	OnStream SC-x0 tape devices
		  0 = /dev/osst0		First OnStream SCSI tape, mode 0
		  1 = /dev/osst1		Second OnStream SCSI tape, mode 0
		    ...
		 32 = /dev/osst0l		First OnStream SCSI tape, mode 1
		 33 = /dev/osst1l		Second OnStream SCSI tape, mode 1
		    ...
		 64 = /dev/osst0m		First OnStream SCSI tape, mode 2
		 65 = /dev/osst1m		Second OnStream SCSI tape, mode 2
		    ...
		 96 = /dev/osst0a		First OnStream SCSI tape, mode 3
		 97 = /dev/osst1a		Second OnStream SCSI tape, mode 3
		    ...
		128 = /dev/nosst0		No rewind version of /dev/osst0
		129 = /dev/nosst1		No rewind version of /dev/osst1
		    ...
		160 = /dev/nosst0l		No rewind version of /dev/osst0l
		161 = /dev/nosst1l		No rewind version of /dev/osst1l
		    ...
		192 = /dev/nosst0m		No rewind version of /dev/osst0m
		193 = /dev/nosst1m		No rewind version of /dev/osst1m
		    ...
		224 = /dev/nosst0a		No rewind version of /dev/osst0a
		225 = /dev/nosst1a		No rewind version of /dev/osst1a
		    ...

		The OnStream SC-x0 SCSI tapes do not support the
		standard SCSI SASD command set and therefore need
		their own driver "osst". Note that the IDE, USB (and
		maybe ParPort) versions may be driven via ide-scsi or
		usb-storage SCSI emulation and this osst device and
		driver as well.  The ADR-x0 drives are QIC-157
		compliant and don't need osst.

207 char	Compaq ProLiant health feature indicate
		  0 = /dev/cpqhealth/cpqw	Redirector interface
		  1 = /dev/cpqhealth/crom	EISA CROM
		  2 = /dev/cpqhealth/cdt	Data Table
		  3 = /dev/cpqhealth/cevt	Event Log
		  4 = /dev/cpqhealth/casr	Automatic Server Recovery
		  5 = /dev/cpqhealth/cecc	ECC Memory
		  6 = /dev/cpqhealth/cmca	Machine Check Architecture
		  7 = /dev/cpqhealth/ccsm	Deprecated CDT
		  8 = /dev/cpqhealth/cnmi	NMI Handling
		  9 = /dev/cpqhealth/css	Sideshow Management
		 10 = /dev/cpqhealth/cram	CMOS interface
		 11 = /dev/cpqhealth/cpci	PCI IRQ interface

208 char	User space serial ports
		  0 = /dev/ttyU0		First user space serial port
		  1 = /dev/ttyU1		Second user space serial port
		    ...

209 char	User space serial ports (alternate devices)
		  0 = /dev/cuu0			Callout device for ttyU0
		  1 = /dev/cuu1			Callout device for ttyU1
		    ...

210 char	SBE, Inc. sync/async serial card
		  0 = /dev/sbei/wxcfg0		Configuration device for board 0
		  1 = /dev/sbei/dld0		Download device for board 0
		  2 = /dev/sbei/wan00		WAN device, port 0, board 0
		  3 = /dev/sbei/wan01		WAN device, port 1, board 0
		  4 = /dev/sbei/wan02		WAN device, port 2, board 0
		  5 = /dev/sbei/wan03		WAN device, port 3, board 0
		  6 = /dev/sbei/wanc00		WAN clone device, port 0, board 0
		  7 = /dev/sbei/wanc01		WAN clone device, port 1, board 0
		  8 = /dev/sbei/wanc02		WAN clone device, port 2, board 0
		  9 = /dev/sbei/wanc03		WAN clone device, port 3, board 0
		 10 = /dev/sbei/wxcfg1		Configuration device for board 1
		 11 = /dev/sbei/dld1		Download device for board 1
		 12 = /dev/sbei/wan10		WAN device, port 0, board 1
		 13 = /dev/sbei/wan11		WAN device, port 1, board 1
		 14 = /dev/sbei/wan12		WAN device, port 2, board 1
		 15 = /dev/sbei/wan13		WAN device, port 3, board 1
		 16 = /dev/sbei/wanc10		WAN clone device, port 0, board 1
		 17 = /dev/sbei/wanc11		WAN clone device, port 1, board 1
		 18 = /dev/sbei/wanc12		WAN clone device, port 2, board 1
		 19 = /dev/sbei/wanc13		WAN clone device, port 3, board 1
		    ...

		Yes, each board is really spaced 10 (decimal) apart.

211 char	Addinum CPCI1500 digital I/O card
		  0 = /dev/addinum/cpci1500/0	First CPCI1500 card
		  1 = /dev/addinum/cpci1500/1	Second CPCI1500 card
		    ...

212 char	LinuxTV.org DVB driver subsystem

		  0 = /dev/dvb/adapter0/video0    first video decoder of first card
		  1 = /dev/dvb/adapter0/audio0    first audio decoder of first card
		  2 = /dev/dvb/adapter0/sec0      (obsolete/unused)
		  3 = /dev/dvb/adapter0/frontend0 first frontend device of first card
		  4 = /dev/dvb/adapter0/demux0    first demux device of first card
		  5 = /dev/dvb/adapter0/dvr0      first digital video recoder device of first card
		  6 = /dev/dvb/adapter0/ca0       first common access port of first card
		  7 = /dev/dvb/adapter0/net0      first network device of first card
		  8 = /dev/dvb/adapter0/osd0      first on-screen-display device of first card
		  9 = /dev/dvb/adapter0/video1    second video decoder of first card
		    ...
		 64 = /dev/dvb/adapter1/video0    first video decoder of second card
		    ...
		128 = /dev/dvb/adapter2/video0    first video decoder of third card
		    ...
		196 = /dev/dvb/adapter3/video0    first video decoder of fourth card


216 char	USB BlueTooth devices
		  0 = /dev/ttyUB0		First USB BlueTooth device
		  1 = /dev/ttyUB1		Second USB BlueTooth device
		    ...

217 char	USB BlueTooth devices (alternate devices)
		  0 = /dev/cuub0		Callout device for ttyUB0
		  1 = /dev/cuub1		Callout device for ttyUB1
		    ...

218 char	The Logical Company bus Unibus/Qbus adapters
		  0 = /dev/logicalco/bci/0	First bus adapter
		  1 = /dev/logicalco/bci/1	First bus adapter
		    ...

219 char	The Logical Company DCI-1300 digital I/O card
		  0 = /dev/logicalco/dci1300/0	First DCI-1300 card
		  1 = /dev/logicalco/dci1300/1	Second DCI-1300 card
		    ...

220 char	Myricom Myrinet "GM" board
		  0 = /dev/myricom/gm0		First Myrinet GM board
		  1 = /dev/myricom/gmp0		First board "root access"
		  2 = /dev/myricom/gm1		Second Myrinet GM board
		  3 = /dev/myricom/gmp1		Second board "root access"
		    ...

221 char	VME bus
		  0 = /dev/bus/vme/m0		First master image
		  1 = /dev/bus/vme/m1		Second master image
		  2 = /dev/bus/vme/m2		Third master image
		  3 = /dev/bus/vme/m3		Fourth master image
		  4 = /dev/bus/vme/s0		First slave image
		  5 = /dev/bus/vme/s1		Second slave image
		  6 = /dev/bus/vme/s2		Third slave image
		  7 = /dev/bus/vme/s3		Fourth slave image
		  8 = /dev/bus/vme/ctl		Control

		It is expected that all VME bus drivers will use the
		same interface.  For interface documentation see
		http://www.vmelinux.org/.

224 char	A2232 serial card
		  0 = /dev/ttyY0		First A2232 port
		  1 = /dev/ttyY1		Second A2232 port
		    ...

225 char	A2232 serial card (alternate devices)
		  0 = /dev/cuy0			Callout device for ttyY0
		  1 = /dev/cuy1			Callout device for ttyY1
		    ...

226 char	Direct Rendering Infrastructure (DRI)
		  0 = /dev/dri/card0		First graphics card
		  1 = /dev/dri/card1		Second graphics card
		    ...

227 char	IBM 3270 terminal Unix tty access
		  1 = /dev/3270/tty1		First 3270 terminal
		  2 = /dev/3270/tty2		Seconds 3270 terminal
		    ...

228 char	IBM 3270 terminal block-mode access
		  0 = /dev/3270/tub		Controlling interface
		  1 = /dev/3270/tub1		First 3270 terminal
		  2 = /dev/3270/tub2		Second 3270 terminal
		    ...

229 char	IBM iSeries virtual console
		  0 = /dev/iseries/vtty0	First console port
		  1 = /dev/iseries/vtty1	Second console port
		    ...

230 char	IBM iSeries virtual tape
		  0 = /dev/iseries/vt0		First virtual tape, mode 0
		  1 = /dev/iseries/vt1		Second virtual tape, mode 0
		    ...
		 32 = /dev/iseries/vt0l		First virtual tape, mode 1
		 33 = /dev/iseries/vt1l		Second virtual tape, mode 1
		    ...
		 64 = /dev/iseries/vt0m		First virtual tape, mode 2
		 65 = /dev/iseries/vt1m		Second virtual tape, mode 2
		    ...
		 96 = /dev/iseries/vt0a		First virtual tape, mode 3
		 97 = /dev/iseries/vt1a		Second virtual tape, mode 3
		      ...
		128 = /dev/iseries/nvt0		First virtual tape, mode 0, no rewind
		129 = /dev/iseries/nvt1		Second virtual tape, mode 0, no rewind
		    ...
		160 = /dev/iseries/nvt0l	First virtual tape, mode 1, no rewind
		161 = /dev/iseries/nvt1l	Second virtual tape, mode 1, no rewind
		    ...
		192 = /dev/iseries/nvt0m	First virtual tape, mode 2, no rewind
		193 = /dev/iseries/nvt1m	Second virtual tape, mode 2, no rewind
		    ...
		224 = /dev/iseries/nvt0a	First virtual tape, mode 3, no rewind
		225 = /dev/iseries/nvt1a	Second virtual tape, mode 3, no rewind
		    ...

		"No rewind" refers to the omission of the default
		automatic rewind on device close.  The MTREW or MTOFFL
		ioctl()'s can be used to rewind the tape regardless of
		the device used to access it.

231 char	InfiniBand MAD
		0 = /dev/infiniband/umad0
		1 = /dev/infiniband/umad1
		 ...

232-239		UNASSIGNED

240-254 char	LOCAL/EXPERIMENTAL USE
240-254 block	LOCAL/EXPERIMENTAL USE
		Allocated for local/experimental use.  For devices not
		assigned official numbers, these ranges should be
		used in order to avoid conflicting with future assignments.

255 char	RESERVED
255 block	RESERVED

		This major is reserved to assist the expansion to a
		larger number space.  No device nodes with this major
		should ever be created on the filesystem.

 ****	ADDITIONAL /dev DIRECTORY ENTRIES

This section details additional entries that should or may exist in
the /dev directory.  It is preferred that symbolic links use the same
form (absolute or relative) as is indicated here.  Links are
classified as "hard" or "symbolic" depending on the preferred type of
link; if possible, the indicated type of link should be used.


	Compulsory links

These links should exist on all systems:

/dev/fd		/proc/self/fd	symbolic	File descriptors
/dev/stdin	fd/0		symbolic	stdin file descriptor
/dev/stdout	fd/1		symbolic	stdout file descriptor
/dev/stderr	fd/2		symbolic	stderr file descriptor
/dev/nfsd	socksys		symbolic	Required by iBCS-2
/dev/X0R	null		symbolic	Required by iBCS-2

Note: /dev/X0R is <letter X>-<digit 0>-<letter R>.

	Recommended links

It is recommended that these links exist on all systems:

/dev/core	/proc/kcore	symbolic	Backward compatibility
/dev/ramdisk	ram0		symbolic	Backward compatibility
/dev/ftape	qft0		symbolic	Backward compatibility
/dev/bttv0	video0		symbolic	Backward compatibility
/dev/radio	radio0		symbolic	Backward compatibility
/dev/i2o*	/dev/i2o/*	symbolic	Backward compatibility
/dev/scd?	sr?		hard		Alternate SCSI CD-ROM name

	Locally defined links

The following links may be established locally to conform to the
configuration of the system.  This is merely a tabulation of existing
practice, and does not constitute a recommendation.  However, if they
exist, they should have the following uses.

/dev/mouse	mouse port	symbolic	Current mouse device
/dev/tape	tape device	symbolic	Current tape device
/dev/cdrom	CD-ROM device	symbolic	Current CD-ROM device
/dev/cdwriter	CD-writer	symbolic	Current CD-writer device
/dev/scanner	scanner		symbolic	Current scanner device
/dev/modem	modem port	symbolic	Current dialout device
/dev/root	root device	symbolic	Current root filesystem
/dev/swap	swap device	symbolic	Current swap device

/dev/modem should not be used for a modem which supports dialin as
well as dialout, as it tends to cause lock file problems.  If it
exists, /dev/modem should point to the appropriate primary TTY device
(the use of the alternate callout devices is deprecated).

For SCSI devices, /dev/tape and /dev/cdrom should point to the
``cooked'' devices (/dev/st* and /dev/sr*, respectively), whereas
/dev/cdwriter and /dev/scanner should point to the appropriate generic
SCSI devices (/dev/sg*).

/dev/mouse may point to a primary serial TTY device, a hardware mouse
device, or a socket for a mouse driver program (e.g. /dev/gpmdata).

	Sockets and pipes

Non-transient sockets and named pipes may exist in /dev.  Common entries are:

/dev/printer	socket		lpd local socket
/dev/log	socket		syslog local socket
/dev/gpmdata	socket		gpm mouse multiplexer

	Mount points

The following names are reserved for mounting special filesystems
under /dev.  These special filesystems provide kernel interfaces that
cannot be provided with standard device nodes.

/dev/pts	devpts		PTY slave filesystem
/dev/shm	tmpfs		POSIX shared memory maintenance access

 ****	TERMINAL DEVICES

Terminal, or TTY devices are a special class of character devices.  A
terminal device is any device that could act as a controlling terminal
for a session; this includes virtual consoles, serial ports, and
pseudoterminals (PTYs).

All terminal devices share a common set of capabilities known as line
diciplines; these include the common terminal line dicipline as well
as SLIP and PPP modes.

All terminal devices are named similarly; this section explains the
naming and use of the various types of TTYs.  Note that the naming
conventions include several historical warts; some of these are
Linux-specific, some were inherited from other systems, and some
reflect Linux outgrowing a borrowed convention.

A hash mark (#) in a device name is used here to indicate a decimal
number without leading zeroes.

	Virtual consoles and the console device

Virtual consoles are full-screen terminal displays on the system video
monitor.  Virtual consoles are named /dev/tty#, with numbering
starting at /dev/tty1; /dev/tty0 is the current virtual console.
/dev/tty0 is the device that should be used to access the system video
card on those architectures for which the frame buffer devices
(/dev/fb*) are not applicable.	Do not use /dev/console
for this purpose.

The console device, /dev/console, is the device to which system
messages should be sent, and on which logins should be permitted in
single-user mode.  Starting with Linux 2.1.71, /dev/console is managed
by the kernel; for previous versions it should be a symbolic link to
either /dev/tty0, a specific virtual console such as /dev/tty1, or to
a serial port primary (tty*, not cu*) device, depending on the
configuration of the system.

	Serial ports

Serial ports are RS-232 serial ports and any device which simulates
one, either in hardware (such as internal modems) or in software (such
as the ISDN driver.)  Under Linux, each serial ports has two device
names, the primary or callin device and the alternate or callout one.
Each kind of device is indicated by a different letter.	 For any
letter X, the names of the devices are /dev/ttyX# and /dev/cux#,
respectively; for historical reasons, /dev/ttyS# and /dev/ttyC#
correspond to /dev/cua# and /dev/cub#.	In the future, it should be
expected that multiple letters will be used; all letters will be upper
case for the "tty" device (e.g. /dev/ttyDP#) and lower case for the
"cu" device (e.g. /dev/cudp#).

The names /dev/ttyQ# and /dev/cuq# are reserved for local use.

The alternate devices provide for kernel-based exclusion and somewhat
different defaults than the primary devices.  Their main purpose is to
allow the use of serial ports with programs with no inherent or broken
support for serial ports.  Their use is deprecated, and they may be
removed from a future version of Linux.

Arbitration of serial ports is provided by the use of lock files with
the names /var/lock/LCK..ttyX#.	 The contents of the lock file should
be the PID of the locking process as an ASCII number.

It is common practice to install links such as /dev/modem
which point to serial ports.  In order to ensure proper locking in the
presence of these links, it is recommended that software chase
symlinks and lock all possible names; additionally, it is recommended
that a lock file be installed with the corresponding alternate
device.	 In order to avoid deadlocks, it is recommended that the locks
are acquired in the following order, and released in the reverse:

	1. The symbolic link name, if any (/var/lock/LCK..modem)
	2. The "tty" name (/var/lock/LCK..ttyS2)
	3. The alternate device name (/var/lock/LCK..cua2)

In the case of nested symbolic links, the lock files should be
installed in the order the symlinks are resolved.

Under no circumstances should an application hold a lock while waiting
for another to be released.  In addition, applications which attempt
to create lock files for the corresponding alternate device names
should take into account the possibility of being used on a non-serial
port TTY, for which no alternate device would exist.

	Pseudoterminals (PTYs)

Pseudoterminals, or PTYs, are used to create login sessions or provide
other capabilities requiring a TTY line dicipline (including SLIP or
PPP capability) to arbitrary data-generation processes.	 Each PTY has
a master side, named /dev/pty[p-za-e][0-9a-f], and a slave side, named
/dev/tty[p-za-e][0-9a-f].  The kernel arbitrates the use of PTYs by
allowing each master side to be opened only once.

Once the master side has been opened, the corresponding slave device
can be used in the same manner as any TTY device.  The master and
slave devices are connected by the kernel, generating the equivalent
of a bidirectional pipe with TTY capabilities.

Recent versions of the Linux kernels and GNU libc contain support for
the System V/Unix98 naming scheme for PTYs, which assigns a common
device, /dev/ptmx, to all the masters (opening it will automatically
give you a previously unassigned PTY) and a subdirectory, /dev/pts,
for the slaves; the slaves are named with decimal integers (/dev/pts/#
in our notation).  This removes the problem of exhausting the
namespace and enables the kernel to automatically create the device
nodes for the slaves on demand using the "devpts" filesystem.

