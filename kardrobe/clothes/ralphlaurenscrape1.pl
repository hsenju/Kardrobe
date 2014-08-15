#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'ralphlaurenlinks2.txt');
                                                                                                                                                               
	#print $file, "\n";
open (my $MYFILE, '<:encoding(iso-8859-1)', "ralphlaurentext2.txt" ) or die $!;
	#my ($dir, $title) = split(/\//, $_);                                                                                                                                           
my $text = join("\n", <$MYFILE>);

	# print $OUTFILE "i\n";
	my $name;
	while ( $text =~ /addVariable\("link", escape\("(.+?)"\)\);/gs ) {
#	while ( $text =~ /fo196.addVariable/gs ) {
	    print $OUTFILE "http://www.ralphlauren.com".$1."\n";;
	}
close ($MYFILE);
close ($OUTFILE);
