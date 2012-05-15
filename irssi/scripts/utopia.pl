use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
use Clipboard;

our $VERSION = '0.5';
our %IRSSI = (
authors     => 'Erik Moqvist',
contact     => 'erik.moqvist@gmail.com',
name        => 'Utopia',
description => 'Utopia related help',
changed     => 'Thu Apr 19 18:33:28 CEST 2012',
);

Irssi::print "$IRSSI{name} version $VERSION loaded, see the top of the script for help";

Irssi::command_bind('cb','cmd_cbclipboard');

# The Province of komp (1:34)
# [http://www.utopiatemple.com Angel v2.08 Beta 2]
# 
# Server: World of Legends (Age 53)
# Utopian Date: June 23rd, YR9 (87% in the day)
# RL Date: April 19th, 2012 (16:52 GMT)
# 
# Ruler Name: The Wealthy Knight vist
# Personality & Race: The Merchant, Human
# Land: 1,034 Acres
# Money: 953,669gc (40,495gc daily income)
# Food: 61,131 bushels
# Runes: 2,828 runes
# Population: 26,450 citizens (25.58 per Acre)
# Peasants: 8,083 (84% Building Efficiency)
# Trade Balance: 115,437gc (0% tax rate)
# 
# ME+Stance (spells*): 121.78% off. / 106.58% def.
# Soldiers: 0 (64% estimated draft rate)
# Swordsmen: 0
# Archers: 5,876 (31,312 defense)
# Knights: 9,086 (88,517 offense / 29,050 defense)
# War-Horses: 2,760 (up to 3,361 additional offense)
# Prisoners: 80 (292 offense)
# 
# Total Modified Offense: 92,170 (89.14 per Acre)
# Practical (100% elites): 92,170 (89.14 per Acre)
# Total Modified Defense: 60,362 (58.38 per Acre)
# Practical (0% elites): 31,312 (30.28 per Acre)
# 
# Thieves: 1,975 (1.91 per Acre / 67% Stealth)
# Wizards: 1,430 (1.38 per Acre / 85% Mana)
# 
# Spy on Throne on your province will show:
# Max. Possible Thieves/Wizards: 5,608 (5.42 / Acre)
# Estimated Thieves Number: 2,243 (2.17 per Acre)
# Estimated Wizards Number: 841 (0.81 per Acre)
# 
# ** Networth Table: **
# Total Networth: 174,296gc (168.56 per Acre)
# Knights: 59,059gc (34%) - [6.5gc]
# Land (90% built): 52,734gc (30%) - [15+40gc]
# Archers: 29,380gc (17%) - [5gc]
# Science (estimated): 8,810gc (5%) - [1/92gc]
# Peasants: 8,083gc (5%) - [1gc]
# Thieves: 7,900gc (5%) - [4gc]
# Wizards: 5,720gc (3%) - [4gc]
# War Horses: 1,656gc (1%) - [0.6gc]
# Money: 954gc (1%) - [1/1000gc]
# 
# Buildings: 815gc to build, 415gc to raze
# (*) Active Spells explained: http://spells.cuts.name

# [23:12] <rick> >>7 HungLikeAMouse (5:38) <<7 Elf Mystic
# [23:12] <rick> Land:6 3745 GC:12 63k Food:12 205k Runes:12 576k
# [23:12] <rick> NW:6 645k (172) Off:4 226k (60) Def:4 263k (70)
# [23:12] <rick> Export:3 }ya97b$62?,7]cJ'vT9!SL'jpnA'/dk2/|!dI3xqPCiPbS\7a 0717B\Ci22

sub cmd_cbclipboard {
    my ($arguments, $server, $witem) = @_;

    my $cb = Clipboard->paste;

    if ($cb =~ /\*\* Export Line \[ver \d+\] -- Throne \[ver \d+\]: \*\*(.*)/s) {
	# SoT in clipboard
	my $expLine = $1;
	$expLine =~ s/\n//g;
	
	$cb =~ /The Province of ([^\n]+)/;
	my $prov = $1;
	
	$cb =~ /Personality & Race: ([^\n]+)/; 
	my $racepers = $1;
	
	$cb =~ /Land: ([^ ]+)/; 
	my $land = $1;
	$land =~ s/,//g;
	
	$cb =~ /Money: ([^g]+)/; 
	my $gc = $1;
	$gc =~ s/,//g;
	$gc /= 1000;
	
	$cb =~ /Food: ([^ ]+)/; 
	my $food = $1;
	$food =~ s/,//g;
	$food /= 1000;
	
	$cb =~ /Runes: ([^ ]+)/; 
	my $runes = $1;
	$runes =~ s/,//g;
	$runes /= 1000;
	    
	$cb =~ /Total Networth: ([^g]+)/;
	my $nw = $1;
	$nw =~ s/,//g;
	my $nwpa = int($nw / $land);

	$cb =~ /Total Modified Offense: ([^ ]+)/;
	my $off = $1;
	$off =~ s/,//g;
	$cb =~ /Total Modified Defense: ([^ ]+)/;
	my $def = $1;
	$def =~ s/,//g;

	my $opa = int($off / $land);
	my $dpa = int($def / $land);
	
	$server->command("msg $witem->{'name'} SoT >>" . chr(3) . "7" . " " . $prov . chr(3) . " << " .
			 chr(3) . "7" . $racepers);
	$server->command("msg $witem->{'name'} Land:" . chr(3) . "6 " . $land . chr(3) .
			 " GC:" . chr(3) . "12 " . int($gc) . "k" . chr(3) .
			 " Food:" . chr(3) . "12 " . int($food) . "k" . chr(3) .
			 " Runes:" . chr(3) . "12 " . int($runes) . "k");
	$server->command("msg $witem->{'name'} NW:" . chr(3) . "6 " . int($nw / 1000) . "k (" . $nwpa . ")" . chr(3) .
			 " Off:" . chr(3) . "4 " . int($off / 1000) . "k (" . $opa . ")" . chr(3) .
			 " Def:" . chr(3) . "4 " . int($def / 1000) . "k (" . $dpa . ")");
	$server->command("msg $witem->{'name'} Export:" . chr(3) . "3 " . $expLine);
    } elsif ($cb =~ /\*\* Export Line \[ver \d+\] -- Military \[ver \d+\]: \*\*(.*)/s) {
	# SoM in clipboard
	my $expLine = $1;
	$expLine =~ s/\n//g;

	$cb =~ /Military Intelligence on ([^\n]+)/;
	my $prov = $1;
	
	$cb =~ /Personality & Race: ([^\n]+)/; 
	my $racepers = $1;
	
	$server->command("msg $witem->{'name'} SoM >>" . chr(3) . "7" . " " . $prov . chr(3) . " << " .
			 chr(3) . "7" . $racepers);
	$server->command("msg $witem->{'name'} Export:" . chr(3) . "3 " . $expLine);
    }
}

Irssi::command_bind('infos','cmd_info');

sub cmd_info {
    my ($arguments, $server, $witem) = @_;
    Irssi::print chr(3) . "7Qvist           Suicidal                  Orc/Tactican";
    Irssi::print chr(3) . "7Dwarp           Trichotillomaniac         Orc/Warrior";
    Irssi::print chr(3) . "6MHK             Insomniac                 Faery/Rogue";
    Irssi::print chr(3) . "6DarthRonin      Anxious                   Faery/Rogue";
    Irssi::print chr(3) . "5Funny_Is_Good   Kleptomaniac              Faery/Mystic";
    Irssi::print chr(3) . "5Spica           exobitionist              Faery/Mystic";
    Irssi::print chr(3) . "7iland           delirium tremens          Orc/";
    Irssi::print chr(3) . "10Shifty          Paranoid                  Elf/Mystic";
    Irssi::print chr(3) . "7Sageville       Pyromaniac";
    Irssi::print chr(3) . "7Akash           Narcissistic";
    Irssi::print chr(3) . "7JabbaDeath      Parasomniac";
    Irssi::print chr(3) . "7Katla           Bigorexic";
    Irssi::print chr(3) . "7orchiles        Autistic                  Orc/Cleric";
    Irssi::print chr(3) . "7Vuthy           Hypomaniac ";
    Irssi::print chr(3) . "10Jabbaproly      Schizophrenic             Elf/Mystic";
    Irssi::print chr(3) . "7Myotis          Agoraphobic ";
    Irssi::print chr(3) . "7Ichigo          Megalomaniac ";
    Irssi::print chr(3) . "7ugh             pica ";
    Irssi::print chr(3) . "7HappyFeet       PTSD ";
    Irssi::print chr(3) . "7longbeard       Hypochondriac ";
    Irssi::print chr(3) . "7romulus         OCPD  ";
    Irssi::print chr(3) . "7Adich           Oneirophrenia ";
    Irssi::print chr(3) . "7Kazihn          Perfectionist ";
    Irssi::print chr(3) . "7Luiz            Nightmare  ";

}
