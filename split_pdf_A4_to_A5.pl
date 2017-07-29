#!/usr/bin/env perl
use strict; use warnings;
use PDF::API2;

my $filename = shift || '12.pdf';
my $oldpdf = PDF::API2->open($filename);
my $newpdf = PDF::API2->new;

for my $page_nb (1..$oldpdf->pages) {
my ($page, @cropdata);

$page = $newpdf->importpage($oldpdf, $page_nb);
@cropdata = $page->get_mediabox;
$cropdata[2] /= 2;
$page->cropbox(@cropdata);
$page->trimbox(@cropdata);
$page->mediabox(@cropdata);

$page = $newpdf->importpage($oldpdf, $page_nb);
@cropdata = $page->get_mediabox;
$cropdata[0] = $cropdata[2] / 2;
$page->cropbox(@cropdata);
$page->trimbox(@cropdata);
$page->mediabox(@cropdata);
}

(my $newfilename = $filename) =~ s/(.*)\.(\w+)$/$1.split.$2/;
$newpdf->saveas($newfilename);

__END__
