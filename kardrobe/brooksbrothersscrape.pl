#!/usr/bin/perl                                                                                                                                                                      
use strict;
use warnings;

open (my $OUTFILE, '+>:utf8', 'clothes/outfile.txt');

my $directory = 'www.brooksbrothers.com';
my $directory2 = 'www.brooksbrothers.com/www.brooksbrothers.com';
my $directoryw = 'www.brooksbrothers.com/women/www.brooksbrothers.com';

opendir (DIR, $directory2) or die $!;

my %dup;
while (my $file = readdir(DIR)) {
    if ( $file =~ /^IWCatProductPage\.process\?Merchant_Id=1\&Section_Id=/ ) {                                                                                                                                                               
	#print $file, "\n";
	open (my $MYFILE, '<:encoding(iso-8859-1)', "$directory2/$file" ) or die $!;
	#my ($dir, $title) = split(/\//, $_);                                                                                                                                           

	my $text = join("\n", <$MYFILE>);

	# print $OUTFILE "i\n";
	my $name;
	if ( $text =~ /<div id="productName"><br \/>(.+?)<\/div>/s ) {
	    next if defined $dup{$1};
	    $name = $1;
	    $dup{$1} = 1;
	}
	if ( $name ) {
	    print $OUTFILE "i".$name."\n"; 
	    print $OUTFILE "#title=".$name."\n"; 
	} else {
	    next;
	}

	my $pricecheck= 0;
	if ( $text =~ /<div id="productPriceSku">(.+?)<\/div>/s ) {
	    (my $plain_text1 = $1) =~ s/<[^>]*>//gs;
	    for ($plain_text1) { 
		s/[\n\s\r]+//g;
		s/&nbsp;//g;
		s/Item.+$//g    
	    }
	    $plain_text1 =~ s/(\d)([A-Z])/$1 $2/g;
	    if ($pricecheck == 0){
		print $OUTFILE "#price=".$plain_text1."\n";
		$pricecheck ++;
	    }
	}

	print $OUTFILE "#link=http://www.brooksbrothers.com/".$file."\n";

	if ($text =~ /image.setAttribute\("data-zoomsrc", "(.+?)"\);/s){
	    my $plain_text = $1;
	    $file =~ /default_color=(.+?)$/;
	    $1 =~ /(.+?)\&/;
	    my $color = uc $1;
	    my $plain_text2 = $plain_text;
            $plain_text2 =~ s/"\+swatchColor\+"/$color/;	    
	    print $OUTFILE "#imglink=".$plain_text2."\n";
	}
	
	if ( $text =~ /<div style="clear:left;line-height:13px;padding:10px 0;">(.+?)<\/div>/s){	   
	    (my $plain_text = $1) =~ s/<[^>]*>//gs;
	    (my $plain_text2 = $plain_text) =~ s/[[:punct:]]//g;
	    my $plain_text3 = lc $plain_text2;
	    for ($plain_text3){
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
