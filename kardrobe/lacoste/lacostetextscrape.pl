#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'lacostewomanlinks.txt');
                                                                                                                                                               
	#print $file, "\n";
open (my $MYFILE, '<:encoding(iso-8859-1)', "womanspage.txt" ) or die $!;
	#my ($dir, $title) = split(/\//, $_);                                                                                                                                           
my $text = join("\n", <$MYFILE>);

	# print $OUTFILE "i\n";
	my $name;
	while ( $text =~ /<span class="miniDetailTargetImage">.+?<a href="(.+?)">/gs ) {
#	while ( $text =~ /fo196.addVariable/gs ) {
	    print $OUTFILE $1."\n";;
	}
close ($MYFILE);
close ($OUTFILE);
