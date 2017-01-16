'# Options

:sy off         syntax off
:sy on          syntax on
:set nu         aktivate line numbering
:se nonu        deactivate line numbering
:set noccompatible
:set showmode   show mode
:se all         show all options
:se ai          turns on autoidentation
:se noai        turns of autoidentation
:se bf          Discards control characters
:syntax on          Turn on syntax highlighting
:syntax off         Turn off syntax highlighting
:set syntax=perl    Force syntax highlighting


# Basics

:e          filename Open filename for edition
:w          Save file
:q          Exit Vim
:q!         Quit without saving
:x               Write file (if changes has been made) and exit
:sav filename    Saves file as filename
.               Repeats the last change made in normal mode
5.              Repeats 5 times the last change made in normal mode
v               visual mode :w save selected in file
:r              Retrievs disk file FILENAME and puts it below the cursor

# Moving in the file

k or Up Arrow   move the cursor up one line
j or Down Arrow move the cursor down one line
e               move the cursor to the end of the word
w		move the cursor one word forward
b               move the cursor to the begining of the word
0               move the cursor to the begining of the line
G               move the cursor to the end of the file
gg              move the cursor to the begining of the file
L               move the cursor to the bottom of the screen
H               move the cursor on the begining of Display
:59             move cursor to line 59. Replace 59 by the desired line number.
20|             move cursor to column 20.
%               Move cursor to matching parenthesis
[[              Jump to function start
{{              Jump to block start
$ 		Jump the cursor to the end of line

# Cut, copy, paste, append

i           Insert before cursor
I           Insert on the begining of the line
y           Copy the selected text to clipboard
p           Paste clipboard contents
dd          Cut current line
d$          Cut to the end of the file
yy          Copy current line
y$          Copy to end of line
D           Cut to end of line
A           Append after the Line
U           Undo to original line
u           Undo U
Ctrl-R      Redo
p           Put line below the cursor
rx          Replace character at the cursor
ce          Change after the end of the world
c$          Change to the end of line
:v/\S/d     Cut all blanc lines
:b1         Switch to buffer 1 and p in the working file
.           Repeat paste or delete
@:	    Repeat last command

# Search

/word           Search word from top to bottom
?word           Search word from bottom to top
/word/C         Search case sensitive
/word           Search case non-sensitive
n               Next found
*               Search the word under cursor
/\cstring       Search STRING or string, case insensitive
/jo[ha]n        Search john or joan
/\< the         Search the, theatre or then
/the\>          Search the or breathe
/\< the\>       Search the
/\< ¦.\>        Search all words of 4 letters
/\/             Search fred but not alfred or frederick
/fred\|joe      Search fred or joe
/\<\d\d\d\d\>   Search exactly 4 digits
/^\n\{3}                            Find 3 empty lines
:bufdo /searchstr/                  Search in all open files
bufdo %s/something/somethingelse/g  Search something in all the open buffers and replace it with somethingelse
ggn             jump to 1st match
GN              jump to last match

# Replace

:%s/old/new/g           Replace all occurences of old by new in file
:%s/onward/forward/gi   Replace onward by forward, case unsensitive
:%s/old/new/gc          Replace all occurences with confirmation
:2,35s/old/new/g        Replace all occurences between lines 2 and 35
:5,$s/old/new/g         Replace all occurences from line 5 to EOF
:%s/^/hello/g           Replace the begining of each line by hello
:%s/$/Harry/g           Replace the end of each line by Harry
:%s/onward/forward/gi   Replace onward by forward, case unsensitive

# Delete

:%s/ *$//g              Delete all white spaces
:g/string/d             Delete all lines containing string
:v/string/d             Delete all lines containing which didn’t contain string
:s/Bill/Steve/          Replace the first occurence of Bill by Steve in current line
:s/Bill/Steve/g         Replace Bill by Steve in current line
:%s/Bill/Steve/g        Replace Bill by Steve in all the file
rx                      Replace character under cursor
:v/\S/d                 Delate all blanc lines
d$                      Delete line right from the cursor

# Case

Vu              Lowercase line
VU              Uppercase line
g~~             Invert case
vEU             Switch word to uppercase
vE~             Modify word case
ggguG           Set all text to lowercase
gggUG           Set all text to uppercase
:set ignorecase Ignore case in searches
:set smartcase  Ignore case in searches excepted if an uppercase letter is used
:%s/\<./\u&/g   Sets first letter of each word to uppercase
:%s/\<./\l&/g   Sets first letter of each word to lowercase
:%s/.*/\u&      Sets first letter of each line to uppercase
:%s/.*/\l&      Sets first letter of each line to lowercase

# Read/Write files

:1,10 w outfile         Saves lines 1 to 10 in outfile
:1,10 w >> outfile      Appends lines 1 to 10 to outfile
:r infile               Insert the content of infile
:23r infile             Insert the content of infile under line 23

# File explorer

:e .                    Open integrated file explorer
:Sex                    Split window and open integrated file explorer
:Sex!                   Same as :Sex but split window vertically
:browse e               Graphical file explorer
:ls                     List buffers
:cd ..                  Move to parent directory
:args                   List files
:args *.php             Open file list
:grep expression *.php  Returns a list of .php files contening expression
gf                      Open file name under cursor

# Interact with Unix

:!pwd       Execute the pwd unix command, then returns to Vi
!!pwd       Execute the pwd unix command and insert output in file
:sh         Temporary returns to Unix
$exit       Retourns to Vi

# Alignment

:%!fmt      Align all lines
!}fmt       Align all lines at the current position
5!!fmt      Align the next 5 lines

# Tabs/Windows

:tabnew                 Creates a new tab
gt                      Show next tab
:tabfirst               Show first tab
:tablast                Show last tab
:tabm n(position)       Rearrange tabs
:tabdo %s/foo/bar/g     Execute a command in all tabs
:tab ball               Puts all open files in tabs
:new abc.txt            Edit abc.txt in new window

# Window spliting

:e filename             Edit filename in current window
:split filename         Split the window and open filename
ctrl-w up arrow         Puts cursor in top window
ctrl-w ctrl-w           Puts cursor in next window
ctrl-w_                 Maximize current window vertically
ctrl-w|                 Maximize current window horizontally
ctrl-w=                 Gives the same size to all windows
10 ctrl-w+              Add 10 lines to current window
:vsplit file            Split window vertically
:sview file             Same as :split in readonly mode
:hide                   Close current window
:­nly                   Close all windows, excepted current
:b 2                    Open #2 in this window

# Auto-completion

Ctrl+n Ctrl+p (in insert mode)  Complete word
Ctrl+x Ctrl+l                   Complete line
:set dictionary=dict            Define dict as a dictionnary
Ctrl+x Ctrl+k                   Complete with dictionnary

# Marks

m {a-z}             Marks current position as {a-z}
' {a-z}             Move to position {a-z}
''                  Move to previous position

# Abbreviations

:ab mail mail@provider.org  Define mail as abbreviation of mail@provider.org

# Text indent

:set cindent
==                  Visualmode  
:set autoindent     Turn on auto-indent
:set smartindent    Turn on intelligent auto-indent
:set shiftwidth=4   Defines 4 spaces as indent size
ctrl-t, ctrl-d      Indent/un-indent in insert mode
>>                  Indent
<<                  Un-indent
=%                  Indent the code between parenthesis
1GVG=               Indent the whole file
gg=G                indent
:%s/^/vendor_/      put 1 word in each intendent line
Ctrl+V,j,c,"word",ESC   put 1 word in intendented lines

# Syntax highlighting

:syntax on          Turn on syntax highlighting
:syntax off         Turn off syntax highlighting
:set syntax=perl    Force syntax highlighting

# Help

:help w
:help c_CTRL-D
:help insert-index
:help user-manual

#shell

:!UNIX_command      run single command
:sh                 start up shell
:r!command          insert the output from a UNIX command into a file
