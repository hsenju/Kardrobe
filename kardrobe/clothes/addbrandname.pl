#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'outfiledefault2.txt');
                                                                                                                                                               
open (my $MYFILE, '<:encoding(iso-8859-1)', "outfiledefault.txt" ) or die $!;                                                                                                                                           

while (<$MYFILE>){
	
    if ( $_ =~ /^#link=http:\/\/(.+?)\// ) {
	    print $OUTFILE "#brand=".$1."\n";
	}
	else {print $OUTFILE $_;}
}

close ($MYFILE);
close ($OUTFILE);
