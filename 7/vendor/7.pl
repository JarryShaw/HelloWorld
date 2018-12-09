#!/usr/bin/env perl
use utf8;
q{

=pod

=encoding UTF8

=head1 NAME

7 - an esoteric programming language

=head1 SYNOPSIS

./7 program.7      # run
./7 -d program.7   # debug

=head1 DESCRIPTION

7 is an esoteric programming language, inspired by Underload (although
it has diverged somewhat), but aiming for small source code
representation.

The language operates using two main pieces of internal state: the
I<frame>, which is a vaguely stack-like construct that holds data; and
the I<command list>.  The frame consists of a sequence of commands
separated by I<bars>; the command list is also a sequence of commands.

The program operates by repeatedly removing the first command from the
command list, then performing the action specified by that command on
the frame.  Once the command list is empty, the portion of the frame
to the right of the last bar is copied to the start of the command
list; this operation is called "cycling".  (Cycling exits the program
if the frame is completely empty, and is an error if the frame is
nonempty but has no bars; also, as a special case, it deletes the
rightmost bar if nothing is to its right, in order to avoid a trivial
infinite loop.)  These are the only ways in which the command list can
be modified.

The frame is a "working space" for the program, and so can be modified
in rather more interesting ways than the command list.  However,
typically only the section to the right of the rightmost bar is
modified, so operations tend to be fairly local and self-contained.

=head2 Frame operations

There is a range of basic operations that can be performed on the
frame:

=over 4

=item *

You can I<append> something to the frame, either a bar or a command.
This adds the bar or command in question to the right of the frame.

=item *

You can I<disbar> the frame, removing the rightmost bar ("closing the
gap" where the bar was in the process).

=item *

You can I<copy> a section of the frame to the end.  A section is the
region of the frame between two bars, or from a bar to an end of the
frame.  When copying a section, a bar is placed to separate the copy
from the rest of the frame.

=item *

You can I<move> a section of the frame to the end.  This is like
copying, except that original section (together with one of the bars
between it and the adjacent sections) is removed.

=item *

You can I<delete> the end of the frame, again from the rightmost bar
onwards.  This will delete the bar in the process.

=item *

You can I<output> the end of the frame to the user.  This outputs the
area strictly beyond the rightmost bar.  (Bars themselves are never
output, because they have no representation as a sequence of bits.)

=item *

You can I<pacify> the end of the frame, beyond the rightmost bar; this
is the most complex operation.  To understand this, the first thing to
note is that the commands come in pairs; each I<active> command is
paired with a I<passive> command.  Additionally, some commands have
names, and some do not have names, We can then describe the process as
follows:

=over 4

=item 1.

The "passive regions" of the section are identified.  These are
regions in which all the commands are named, and for which C<7> and
C<6> commands are correctly matched, as though they were parentheses;
additionally, the substring C<76> cannot appear in a passive region.
Passive regions are made as long as possible while respecting these
rules.

=item 2.

Each passive region is enclosed between a C<7> and C<6> command.

=item 3.

Each command outside any passive region (which must by definition be
active, as all anonymous commands are active, as are C<6> and C<7>) is
converted to the corresponding passive command.

=back

=back

=head2 Commands

Now that we've defined the basic frame operations, it's possible to
define the commands.

Eight of the twelve commands have numerical names, used in the source
code representation: the six passive commands, and two active
commands.  The other four active commands have no numerical name (and
cannot appear in the source), and are given names in English to
identify them.

=over 4

=item C<6> (active), C<0> (passive): Pacify then disbar

The C<6> command pacifies the rightmost section of the frame, and then
the frame is disbarred.  The passive equivalent C<0> appends a C<6>
command to the frame.

=item C<7> (active), C<1> (passive): Append a bar

The C<7> command appends a bar to the frame.  The passive equivalent
C<1> appends a C<7> command to the frame.

=item "copy" (active), C<2> (passive): Copy the rightmost section

The "copy" command copies the rightmost section of the frame to the
end of the frame.  The passive equivalent C<2> appends a "copy"
command to the frame.

=item "recycle" (active) C<5> (passive): Cycle early, then delete

The "recycle" command cycles a copy of the rightmost section of the
frame onto the command list, even if the command list isn't empty.
After doing that, it deletes the rightmost section of the frame
(including the bar that separates it from the rest of the frame).  The
passive equivalent C<5> appends a "recycle" command to the frame.

=item "grab" (active), C<4> (passive): Swap, with extra bars

The "grab" command appends an extra bar to the frame then moves the
new third-rightmost section (the original second-rightmost section) of
the frame to the end of the frame.  The passive equivalent C<4>
appends a "grab" command to the frame. 

=item "eject" (active), C<3> (passive): Output, then delete twice

The "eject" command outputs the end of the frame (beyond the rightmost
bar) to the user, then deletes the end of the frame from the
second-rightmost bar onwards (i.e. deletes the end of the frame
twice).  Exception: if the section of the frame that would be output
contains any unnamed commands, it is pacified first (pacification
leaves a region with only named commands), and a C<7> is prepended to
the output.  The passive equivalent C<3> appends an "eject" command to
the frame.

This command is also capable of producing input in some circumstances
(via outputting special codes which mean "read input").  Although the
input can be in more than one form, it's always provided to the
program as a nonnegative integer, and affects the program like this:
after the deletions from the frame, the new rightmost section of the
frame (not including the bar to its left) has its content repeated a
number of times equal to the input (e.g. 0 would remove everything to
the right of the rightmost bar, 1 would do nothing, 2 would add an
extra copy of the text to the rightmost bar, and so on.)  When reading
in integers from the user, any leading whitespace and commas are
skipped, then a decimal integer is read, with any stray characters
"after" the integer being left for future input commands; if there's
no integer available, 0 will be returned (this is also a valid
integer, so you may want to alternate between character and integer
reading to detect invalid input and EOF).  When reading in characters,
they're converted to a character code, and 1 is added to them (EOF
counts as character code -1, and thus will produce 0 copies).

The very first command output via this command does not produce
output, but rather specifies the format of future output:

=over 4

=item Numerical (C<0>)

In each command list output, a value is calculated like this: the
total number of C<7> and C<1> commands, minus the total number of C<6>
and C<0> commands.  Exception: if the output was automatically
pacified (and thus had a C<7> prepended), that C<7> does not count in
the total count of C<7> commands.  This integer is converted to
decimal and output.

Formatting can be controlled via outputting commands other than
strings of C<0>, C<1>, C<6>, C<7>.  The output will be preceded by a
space, unless it's the first output on the line.  A C<2> at the end of
the string will output a trailing newline. A C<3> at the end of the
string will append a comma to it. C<4> and C<5> can be placed at
either end of the string, and will turn into opening and closing
square brackets respectively.

Input can be obtained via attempting to output C<23> (numerical input)
or C<24> (character input).  Outputting C<25> allows selection of a
new output format (basically by "resetting" the format, meaning that
the next command to be output will select a format again).

=item Byte-per-command (C<1>)

Each command is output as an individual byte (thus the only bytes
output will be the digits C<0> to C<7> inclusive, as those are the
only bytes that name commands).  This format does not support input.

=item Character code as number (C<2>)

This is similar to the numerical output C<0> explained above, except
that 1 is subracted from the number, and it's then used as a character
code (rather than being output in decimal).  By default, this is in
binary (i.e. octets mod 256), but this can be changed by attempting to
output a negative number; C<-1> selects binary, C<-2> selects UTF-8,
C<-3> inputs a number, C<-4> inputs a character, and C<-5> allows
selection of a new output format.  Commands other than C<0>, C<1>,
C<6>, and C<7> aren't recognised here.

=item Byte-per-three-commands (C<3>)

Any C<6> and C<7> commands in the output are ignored. The others are
taken as triples and interpreted as base-6 numbers (as usual, in a
big-endian way), giving a value from 0 to 215 (decimal), 0 to 555
(base 6).  This is is encoded as follows: if the value is 127
(decimal) or lower (that's 331 in base 6), it's output as an octet
directly; if the value is in the range 128 to 191 (decimal) inclusive
(that's 332 to 515 in base 6), then 64 (decimal), which is 144 (base
6), might or might not be added to it.  Values above 192 (decimal) or
520 (base 6) control this addition; outputting 522 (the default)
requests the addition to happen in a way that makes the output look as
much like UTF-8 as possible; 520 specifies never adding (until this
condition is changed); 521 specifies always adding.  You can also
request input, with 523 requesting an integer and 524 requesting a
character; 525 allows selection of a new output format.  Other values
are currently reserved for future expansion and should not be used.

=item Truncated octal (C<4>)

The output is encoded using the octal source encoding.  However, if it
does not come to a whole number of bytes, any spare bits are discarded
(as opposed to padding them out, as would for example happen with the
source format C<7> when the source were in binary).  This format does
not support input.

=item US-TTY (C<5>)

Any C<6> and C<7> commands in the output are ignored. The others are
taken in pairs and interpreted as base-6 numbers (as usual, in a
big-endian way), giving a value from 0 to 35 (decimal), 0 to 55 (base
6).  These are then in turn interpreted as being in an expanded
version of the US-TTY character set.  This is a 5-bit character set
(thus using values from 0 to 31 (decimal), 0 to 51 (base 6)); the
remaining four codes are reserved for giving instructions to the 7
interpreter itself.  It can encode more than just 31 characters via
the use of shift states; it has five different states, notated here as
Ł, ł, Ŧ, Ø, ø, with Ł being the default.  (Ł and Ŧ are identical,
except that immediately after outputting any character in state Ŧ, the
shift state becomes ł; other shift states are stable until changed
explicitly. State ø is an expansion based on CLC-INTERCAL's version of
Baudot, a very similar character set to US-TTY; US-TTY reserves the
state for use by expansions but does not specify what form those might
take. Note that the tables below are not I<quite> the same as
CLC-INTERCAL's, although they are very close; however, the only
differences are in the meanings of some shift codes, and in the fact
that C<#> appears in two places in order to improve compatibility with
existing US-TTY and CLC-INTERCAL-encoded text.) The character (or
control sequence) encoded depends on the shift state and the sequence
seen.

Here's how the character set looks (shift state down the left side,
character encoding (first then second command) at the top, Ŧ encodes
the same characters as Ł):

   00000011111122222233333344444455
   01234501234501234501234501234501
  
 Ł  E A SIU DRJNFCKTZLWHYPQOBGØMXVł
 ł  e a siu drjnfcktzlwhypqobgØmxvŦ
 Ø  3 -  87 $4',!:(5")2#6019?&ø./;Ł
 ø  ¢ + \#= *{~∀|^<[}>] @ £¬  Ø%_ Ł

C<00> encodes NUL, C<02> encodes newline, C<04> encodes space, C<12>
encodes carriage return, C<05> in state Ø encodes BEL, C<32> in state
ø encodes backspace, C<41> in state ø encodes DEL, other blank squares
are currently undefined and should not be used.

As for the remaining codes, C<53> requests input of an integer, C<54>
requests input of a character, and C<55> allows selection of a new
output format.  C<52> is currently undefined and should not be used.

=item Source (C<7>)

The output is encoded the same way that the source was (and, if
necessary, will be padded with C<1> bits; note that this padding only
occurs if the program ends "naturally", not if it ends abruptly due to
ejecting beyond the bottom of the stack).

=item Other values

Other values are currently undefined and reserved for future extension.

=back

If an attempt is made to delete more sections than exist on the frame
via use of this command, the program exits immediately (although any
output will still be produced).  (A program also exits if the frame
and command list are both empty.)

=back

=head2 Source Encoding

A 7 source file is written via the use of the eight named commands;
the four anonymous commands cannot appear in the original
program. These form the initial command list; the initial frame
consists of two bars (with no commands before, after, or between
them).  Additionally, it is not legal for a program to end with a C<7>
command.  A file can either be written in ASCII, using one byte per
command, or in octal, using three bits per command.  In the latter
case, when storing the program in a file, the commands are written in
such a way that the bit sequence of the commands and of the file are
the same when viewed in a big-endian way.  If there's a need to pad
the end of the program, e.g. to make it round up to a multiple of 8
bits, the program can be padded by appending any number of C<1> bits
(the fact that programs may not end with a C<7> command makes this
unambiguous).  Similarly, any number of consecutive C<1> bits at the
end of the file can be deleted (they're implied into the file when a
partial command is seen).

=cut

} or exit;

use warnings;
use strict;
use feature qw/state/;
use Encode qw/encode/;
use 5.012;

my $debug;

while ($ARGV[0] =~ /^-/) {
    my $option = shift @ARGV;
    $option eq '-d' ? $debug = 1 :
    $option eq '-' ? last :
    die "Unknown option $option";
}

my %usttytable = (
    #        0   0 0000    11 11    1122222   233    333344      444455
    #        0   1 2345    01 23    4501234   501    234501      234501
    'Ł' => "\0"."E\nA S" ."IU\rD". "RJNFCKT".'ZLW'. "HYPQOB".   "GØMXVł",
    'ł' => "\0"."e\na s" ."iu\rd". "rjnfckt".'zlw'. "hypqob".   "gØmxvŦ",
    'Ø' => "\0"."3\n- \a"."87\r\$"."4',!:(5".'")2'. "#6019?".   "&ø./;Ł",
    'ø' => "\0"."¢\n+ \\"."#=\r*". "{~∀|^<[".'}>]'."\b@—£¬\x7F"."—Ø%_—Ł");
$usttytable{'Ŧ'} = $usttytable{'Ł'};

$| = 1; undef $/;
binmode STDIN;
# Note: we leave STDOUT in text mode until the user selects an output format
# that clearly requires binary.
my $program = <>;
my $program_was_binary = 0;
my $bits_per_byte = length unpack "B*", "\0";

if ($program =~ y/01234567 \n\r\t\f//c) {
    # If the program contains anything other than digits, spaces, and
    # \n,\r,\t,\f, then unpack it from binary.
    my $binary = unpack "B*", $program;
    $binary =~ s/1+$//;
    $binary .= 1 while (length $binary) % 3;
    $program = "";
    $program .= oct "0b$&" while $binary =~ s/^...//;
    $program_was_binary = 1;    
} else {
    $program =~ s/\s//g;
}

# Technically we should start with the program on the command list, but
# it's easier to start it on the frame and do an explicit-cycle in order
# to move it into place.
my $frame = "|||$program";
my $delayed_frame_copy = 1;
my @commandlist = ();

my $outformat = undef;

sub pacify {
    local $_ = shift;
    s/((7(?2)+6|[0-5])+)/"7${1}6"=~y:67:89:r/ge;
    y/67cegr89/0-7/;
    $_;
}

my $pending_octal = "";
my $getc_buffer = undef;

sub getin {
    if ($getc_buffer) {
        my $c = $getc_buffer;
        undef $getc_buffer;
        $debug and printf STDERR "\tRereading character code $c\n";
        return $c;
    } else {
        my $c = getc;
        $c = defined $c ? (ord $c) + 1 : 0;
        return $c;
    }
}

sub input_number {
    my $c;
    my $n = 0;
    while (($c = getin) && (chr $c - 1) =~ /\s/) {}
    if (!$c) {
        $debug and print STDERR "\tRead EOF, expecting number\n";
        $delayed_frame_copy = 0;
        return;
    }
    while ((chr $c - 1) =~ /(\d)/) {
        $n *= 10;
        $n += $1;
        $c = getin;
        !$c and last;
    }
    $getc_buffer = $c if $c;
    $debug and print STDERR "\tRead integer value $n\n";
    $delayed_frame_copy = $n;
}

sub input_char {
    my $c = getin;
    $debug and print STDERR (!$c ? "\tRead EOF, expecting character\n" :
                             "Read character code ".($c - 1));
    $delayed_frame_copy = $c;
}

sub oprint {
    local $_ = shift;
    my $autopacify = /\D/;
    state $after_newline = 1;
    $autopacify and $_ = "7" . pacify $_;
    length $_ or return;

    unless (defined $outformat) {
        s/(.)//;
        $outformat = $1;
        $outformat == 7 and !$program_was_binary and $outformat = 1;
        $debug and print STDERR "\tSelected output format $outformat\n";
    }
    [
     sub { # 0: numerical
         $_ eq '23' and input_number, return;
         $_ eq '24' and input_char, return;
         $_ eq '25' and (undef $outformat), return;
         my $result = y/71//;
         $result -= y/60//;
         $result-- if $autopacify;
         print " " unless $after_newline;
         $after_newline = !!/2$/;
         s/^[45]+// and print ($& =~ y/45/[]/r);
         print $result;
         s/[2345]+$// and print ($& =~ y/2345/\n,[]/r);
     },
     sub { # 1: byte per command
         print;
         $after_newline = 0;
     },
     sub { # 2: read numbers, write character codes
         binmode STDOUT;
         state $utf8mode = 0;
         my $result = y/71//;
         $result -= y/60//;
         $result-- if $autopacify;
         if ($result > 0) {
             print $utf8mode ? encode("UTF-8", chr($result - 1)) :
                 encode("ISO-8859-1", chr ($result - 1));
         } else {
             $result == -1 and ($utf8mode = 0), return;
             $result == -2 and ($utf8mode = 1), return;
             $result == -3 and input_number, return;
             $result == -4 and input_char, return;
             $result == -5 and (undef $outformat), return;
             $result == 0 and die "Attempted to output EOF";
             die "Attempted to output negative character code $result";
         }
     },
     sub { # 3: byte per three commands
         state $partial = "";
         state $add64 = 194;
         state $utf8bytes = 0;
         binmode STDOUT;
         s/[67]//g;
         $partial .= $_;
         while ($partial =~ s/^(.)(.)(.)//) {
             my $v = $1*36 + $2 * 6 + $3;
             if ($v < 128) {
                 print chr $v;
                 $utf8bytes = 0;
             } elsif ($v < 192) {
                 if ($add64 == 192 || ($add64 == 194 && $utf8bytes)) {
                     print chr $v;
                     $utf8bytes and $utf8bytes--;
                 } elsif ($add64 == 193 || ($add64 == 194 && !$utf8bytes)) {
                     $v += 64;
                     print chr $v;
                     $utf8bytes = 1; # always at least 1 trailing byte
                     $v >= 0xE0 and ++$utf8bytes;
                     $v >= 0xF0 and ++$utf8bytes;
                     $v >= 0xF8 and ++$utf8bytes;
                     $v >= 0xFC and ++$utf8bytes;
                 }
             } elsif ($v < 195) {
                 $add64 = $v;
             } elsif ($v == 195) {
                 input_number;
             } elsif ($v == 196) {
                 input_char;
             } elsif ($v == 197) {
                 undef $outformat;
             } else {
                 die "Unknown byte-per-three-commands value $v";
             }
         }
     },
     sub { # 4: octal
         state $partial = "";
         binmode STDOUT;
         $partial .= sprintf "%03b", $& while s/%.//;
         print chr oct "0b$&" while $partial =~ s/^.{$bits_per_byte}//;
     },
     sub { # 5: US-TTY
         s/[67]//g;
         state $partial = "";
         state $shiftstate = 'Ł';
         $partial .= $_;
         while ($partial =~ s/^(.)(.)//) {
             my $v = $1 * 6 + $2;
             $v == 33 and input_number, return;
             $v == 34 and input_char, return;
             $v == 35 and (undef $outformat), return;
             my $c = substr $usttytable{$shiftstate}, $v, 1;
             if ($usttytable{$c}) {
                 $shiftstate = $c;
             } elsif ($c eq '—') { # represents an invalid character
                 ...;
             } else {
                 # TODO: Adapt to locale encoding?
                 print encode("UTF-8",$c);
                 $shiftstate eq 'Ŧ' and $shiftstate = 'ł';
             }
         }
     },
     sub { # 6: Unimplemented
         die "Output format 6 is currently undefined";
     },
     sub { # 7: Like source; if we get here, it's octal encoding
         binmode STDOUT;
         $pending_octal .= sprintf "%03b", $& while s/^.//;
         print chr oct "0b$&" while $pending_octal =~ s/^.{$bits_per_byte}//;
     },
    ]->[$outformat]->();
    $debug and print STDERR "\n";
}

my $explicit = 1;
CYCLE: while ($frame ne '') {
    $frame =~ /[|](\w*)$/
        or die "when cycling, frame is nonempty but has no bar";
    my $commandlist = $1;
    $commandlist eq '' and $explicit = 1;
    $explicit and $frame =~ s/[|](\w*)$//;
    $explicit = 0;
    unshift @commandlist, split /([0-57]*)/, $commandlist;
    while (@commandlist) {
        if ($delayed_frame_copy != 1) {
            $frame =~ s/[|]\K(\w*)$/$1 x $delayed_frame_copy/e
                || die "Attempt to read input with no bar in the frame";
            $delayed_frame_copy = 1;
        }
        $debug and print STDERR "\t$frame ", @commandlist, "\n";
        my $command = shift @commandlist;
        length $command or next;
        for ($command) {
            /[0-57]/ and $frame .= $command =~ y/0-57/67cegr|/r;
            /6/ and $frame =~ s/[|](\w*)$/pacify $1/e
                || die "6 command run with no bar in the frame";
            /c/ and $frame =~ s/[|](\w*)$/|$1|$1/
                || die "'copy' command run with no bar in the frame";
            /e/ and $frame =~ s/[|]\w*[|](\w*)$/(oprint $1), ""/e
                ||  $frame =~ s/(\w*)$/         (oprint $1), exit/e;
            /g/ and $frame =~ s/(\w*)[|](\w*)$/$2||$1/
                || die "'grab' command run with no bar in the frame";
            /r/ and $explicit = 1 and next CYCLE;
        }
    }
}

$pending_octal =~ s/1+$//;
if (length $pending_octal) {
    $pending_octal .= 1 until length $pending_octal == $bits_per_byte;
    print chr oct "0b$pending_octal";
}
