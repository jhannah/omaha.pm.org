#!/usr/bin/perl

use CGI;

my $q = CGI->new();
my $blah = $q->param('blah');


print 
   $q->header,
   $q->start_html,
   $q->h1("Ron's First CGI.pm CGI!"),
   "<h1>Jay likes manual HTML better</h1>",
   "Previous entry: $blah<p>\n",
   $q->start_form;

if ($q->param('blah3')) {
   print "Yes sir! I will process blah3 immediately!<br>\n";
}

for (1..10) { 
   print $q->textfield("blah$_"), "<br>\n";
}
print
   $q->submit, 
   $q->end_form,
   $q->end_html;



