# To show all networking related to a given port:
lsof -iTCP -i :port
lsof -i :22

# To show connections to a specific host, use @host
lsof -i@192.168.1.5

# Show connections based on the host and the port using @host:port lsof -i@192.168.1.5:22

# grepping for LISTEN shows what ports your system is waiting for connections on:
lsof -i| grep LISTEN

# Show what a given user has open using -u:
lsof -u daniel

# See what files and network connections a command is using with -c
lsof -c syslog-ng
# The -p switch lets you see what a given process ID has open, which is good for learning more about unknown processes:
lsof -p 10075

# The -t option returns just a PID
lsof -t -c Mail

# Using the -t and -c options together you can HUP processes
kill -HUP $(lsof -t -c sshd)
# You can also use the -t with -u to kill everything a user has open
kill -9 $(lsof -t -u daniel)

lsof -i will provide a list of open network sockets. The -n option will prevent DNS lookups, which is useful when your network connection is slow or unreliable.

lsof +D /some/directory
# Will display recursively all the files opened in a directory. +d for just the top-level.

# This is useful when you have high wait% for IO, correlated to use on a particular FS and want to see which processes are chewing up your io.

S# ee what files a running application or daemon has open:
lsof -p pid
# Where pid is the process ID of the application or daemon.
