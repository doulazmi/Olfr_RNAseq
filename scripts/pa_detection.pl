#!/usr/bin/perl -w 

use strict;
use warnings;
use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use HTML::TableExtract;
my $ua = new LWP::UserAgent;


$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

my $seq="";
open (MET2 ,"< femaleUTR.fa");
my @ligne=<MET2>;
open (FIC_OP2,"> 3UTR_polyAdq_result.txt");


for (my $i=0; $i<=$#ligne; $i=$i+2){
    $seq=$ligne[$i].$ligne[$i+1];                         
    chop ($ligne[$i]);           
    print FIC_OP2 "$ligne[$i]\t";  

    my $req = POST 'https://cb.utdallas.edu/cgi-bin/tools/polyA/polyadq4.cgi',
                        [ seq_text => $seq, organism =>'mouse', cutoff =>'default' ];

    
    my $response = $ua->request($req);
    chomp(my $html =  $response->content);
    my $te = HTML::TableExtract->new(headers => [qw( Prediction  Site  Sequence  Score) ]);
    $te->parse($html);
    foreach my $table ( $te->tables ) {
        foreach my $row ($table->rows) {
              foreach ( grep {defined} @$row)
                    {
                        $_ =~ s/\n/\ /g;
                        $_ =~ s/\r//g;  
                        $_ =~ s/\s+//g;
                    }
            my @values = grep {defined} @$row;

            print FIC_OP2 "", join('_', @values), "\t";
           }
        }
    print FIC_OP2"\n";

    }
close FIC_OP2;
close MET2;
