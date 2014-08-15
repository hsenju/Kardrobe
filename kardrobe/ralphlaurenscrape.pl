#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'clothes/ralphoutfilem2.txt');

my $directory = 'ralphlaurenlinksmen';

opendir (DIR, $directory) or die $!;

my %dup;
while (my $file = readdir(DIR)) {
    if ( $file =~ /^index.jsp/ ) {                                                                                                                                                               
	#print $file, "\n";
	open (my $MYFILE, '<:encoding(iso-8859-1)', "$directory/$file" ) or die $!;
	#my ($dir, $title) = split(/\//, $_);                                                                                                                                           

	my $text = join("\n", <$MYFILE>);

	# print $OUTFILE "i\n";
	my $name;
	if ( $text =~ /<div class="prodtitleLG">(.+?)<\/div>/s ) {
	    next if defined $dup{$1};
	    $name = $1;
	    $dup{$1} = 1;
	}
	if ($name) {
	    $name =~ s/<h1>//g;
            $name =~ s/<\/h1>//g;
	    $name =~ s/^\s+|\s+$//g;
	    print $OUTFILE "i".$name."\n";
	    print $OUTFILE "#title=".$name."\n";
	    print $OUTFILE "b1".$name."\n";
	} else {
	    next;
	}

	my $pricecheck= 0;
	if ( $text =~ /<span class="prodourprice">Price: &#036;(.+?)<\/span>/s ) {
	    if ($pricecheck == 0){
		print $OUTFILE "#price=".'$'.$1."\n";
		$pricecheck ++;
	    }
	}

	print $OUTFILE "#link=http://www.ralphlauren.com/product/".$file."\n";

	if ($text =~ /<img SRC="http:\/\/www.ralphlauren.com\/graphics\/product_images\/(.+?)360x480\.jpg/s){
 	    
	    print $OUTFILE "#imglink=http://www.ralphlauren.com/graphics/product_images/".$1."360x480.jpg\n";
	}
	
	if ($text =~ /<div id = "longDescDiv">(.+?)<br \/>/s){	   
	    (my $plain_text = $1) =~ s/<[^>]*>//gs;
	    (my $plain_text2 = $plain_text) =~ s/[[:punct:]]//g;
	    my $plain_text3 = lc $plain_text2;
	    $_ = $plain_text3;
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
	    s/\d//g;
            s/^\s+|\s+$//g;
	    print $OUTFILE "b1".$_."\n";
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
