#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'lacoste/outfile.txt');

my $directory = 'lacoste';
my $directory2 = 'www.brooksbrothers.com/www.brooksbrothers.com';
my $directoryw = 'www.brooksbrothers.com/women/www.brooksbrothers.com';

opendir (DIR, $directory) or die $!;

my %dup;
while (my $file = readdir(DIR)) {
    if ( $file =~ /^B00/ ) {                                                                                                                                                               
	#print $file, "\n";
	open (my $MYFILE, '<:encoding(iso-8859-1)', "$directory/$file" ) or die $!;
	#my ($dir, $title) = split(/\//, $_);                                                                                                                                           

	my $text = join("\n", <$MYFILE>);

	# print $OUTFILE "i\n";
	my $name;
	if ( $text =~ /<h1 class="productTitle">(.+?)<\/h1>/s ) {
	    next if defined $dup{$1};
	    $name = $1;
	    $dup{$1} = 1;
	}
	if ( $name ) {
            $name =~ s/^\s+|\s+$//g;
	    print $OUTFILE "i".$name."\n"; 
	    print $OUTFILE "#title=".$name."\n"; 
            print $OUTFILE "b1".$name."\n";
	    print $OUTFILE "!".$name."\n";
	} else {
	    next;
	}

	my $pricecheck= 0;
	if ( $text =~ /<dd class="price">(.+?)<\/dd>/s ) {
	    if ($pricecheck == 0){
		(my $plain_text = $1) =~ s/^\s+|\s+$//g;
		print $OUTFILE "#price=".$plain_text."\n";
		$pricecheck ++;
	    }
	}

	print $OUTFILE "#link=http://shop.lacoste.com/dp/".$file."\n";

	if ($text =~ /<img id="productImage" class="productImage" src="(.+?)" alt=".+?" \/>/s){
	    print $OUTFILE "#imglink=".$1."\n";
	}
	
	if ( $text =~ /<div class="productInfo">(.+?)<\/div>/s){	   
	    (my $plain_text = $1) =~ s/<[^>]*>/ /gs;
	    (my $plain_text2 = $plain_text) =~ s/[[:punct:]]//g;
	    my $plain_text3 = lc $plain_text2;
	    for ($plain_text3){
		s/^\s+|\s+$//g;
		s/[\n\s]+/ /gs;
		s/ and//g;
		s/ or//g;
		s/ with//g;
		s/ at//g;
		s/ our//g;
		s/ are//g;
		s/ is//g;
		s/ in//g;
		s/ the//g;
		s/ made//g;
		s/ length//g;
		s/ of//g;
		s/ a//g;
		s/ for//g;
		s/ has//g;
		s/ on//g;
		s/ to//g;
		s/ this//g;
		s/ look//g;
		s/we //g;
		s/\d//g;
}
	    print $OUTFILE "b1".$plain_text3."\n";
	}

#    while (<$MYFILE>)
#   {
#	
#	print $OUTFILE "i".$file."\n";
#        chomp;
#        if ( /^title\s?=\s?(.+)$/ ) {
#            print $OUTFILE "#title=",$1, "\n";
#        }
#        elsif ( /^link\s?=\s?(.+)$/ ) {
#            print $OUTFILE "#link=",$1,"\n";
#        }
#        elsif ( /^imglink\s?=\s?(.+)$/ ) {
#            print $OUTFILE "#imglink=",$1,"\n";
#        }
#        else {
#            print $OUTFILE "b1"."$_\n";
#        }
#    }

	close ($MYFILE);
    }
}
close ($OUTFILE);
closedir (DIR);
