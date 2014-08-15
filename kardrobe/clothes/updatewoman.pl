#!/usr/bin/perl                                                                                                                                                                                                                               
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'outfiledefaultwoman.txt');

open (my $MYFILE, '<:encoding(iso-8859-1)', "ralphoutfilew.txt" ) or die $!;

while (<$MYFILE>){

        if ( $_ =~ /^i(.+?)\n/ ) {
            print $OUTFILE ($_);
            print $OUTFILE "!".lc($1)."\n";
        }
        elsif ( $_ =~ /^b1(.+?)\n/ ){
            print $OUTFILE "b1".lc($1)."\n";
        }
	elsif ( $_ =~ /^#link=http:\/\/(.+?)\// ) {
            print $OUTFILE ($_);        
	    print $OUTFILE "#brand=".$1."\n";
        }
        else {print $OUTFILE $_;}
}

close ($MYFILE);
close ($OUTFILE);

