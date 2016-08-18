use LWP::Simple;
my $filename = "acc.txt";

open my $fh, "<", $filename or die "Can't open file $!";


while(<$fh>)
{
	chomp;
	my $ncbi_url = 'http://www.ncbi.nlm.nih.gov/sviewer/viewer.fcgi?val='.$_.'&db=nuccore&dopt=fasta&extrafeat=0&fmt_mask=0&retmode=html&withmarkup=on&log$=seqview&maxdownloadsize=1000000';
	open my $newfile ,">","$_.fasta";
	my $content_get = get($ncbi_url);
	my ($header) = $content_get =~m/^(>.+?)\n<span/s;
	my @seq = $content_get =~m/<span.+?>([^<]+)/g;
	print $newfile "$header\n@seq";
	print "$_ file created\n";
}

print "Task completed\n\n";
