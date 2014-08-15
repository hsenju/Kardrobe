#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'outfilelc.txt');
                                                                                                                                                               
open (my $MYFILE, '<:encoding(iso-8859-1)', "outfile.txt" ) or die $!;                                                                                                                                           

while (<$MYFILE>){
	
	if ( $_ =~ /^!/ ) {
	    print $OUTFILE lc($_);
	}
        elsif ( $_ =~ /^b1(.+?)\n/ ){
            print $OUTFILE "b1".lc($1)."\n";
        }
	else {print $OUTFILE $_;}
}

close ($MYFILE);
close ($OUTFILE);
