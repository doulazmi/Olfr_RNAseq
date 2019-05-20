#######################################################################
#
# Copyright (C) 2019  Institut de Biologie Paris-Seine
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#####################################################################   

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
