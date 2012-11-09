#!/usr/bin/perl

# ...

my $header .= <<EOT;
Content-type: text

<pre>
Who                        Qty  Size  Color pref.
-------------------------- ---  ----  ----------------
EOT

my $shirts = <<EOT;
[OMA] Jay Hannah            3   XXL   black                (paid)
[OMA] Dean Nicholson        1   XL    ash            `     (paid)
                            1   XL    black                (paid)
[OMA] Ryan Stille           1   XXL   ash                  (paid)
                            2   L     ash                  (paid)
[OMA] Dave Thacker          1   XXL   black                (paid)
                            1   XXL   ash                  (paid)
[OMA] Tim Vidas             1   XXL   black
[OMA] Jay Swackhamer        5   XL    black
[OMA] Josh Kleensang        1   XL    black
[OMA] Richard Norton        1   XXL   ash                  (paid)
[OMA] Mat Caughron          1   XXL   black                (paid)
[OMA] Sean Baker            1   XL    black                (paid)
                            1   XL    ash                  (paid)
[OMA] Brian Wiese           1   L     black                (paid)
                            2   L     ash                  (paid)
                            2   XL    ash                  (paid)
[OMA] Terry Davis           1   XL    ash                  (paid)
[OMA] Sidney Boardman       1   L     black                (paid)
                            1   M     black                (paid)
[SFL] Rocco Caputo          1   L     ash                  (paid)
                            1   XL    ash                  (paid)
[SFL] Gabriel Horner        1   XL    black                (paid)
[SFL] Peter Pezaris         1   XL    black                (paid)
[SFL] Allen Barriere        2   XL    black                (paid)
[SFL] Richard Klein         2   XL    ash                  (paid)
[SFL] Juila Contes          1   S     black                (paid)
[SFL] Amiel Lee Yee         1   XL    black                (paid)
[SFL] Lyle Skolnick         1   L     ash                  (paid)
[SFL] Jeff Bisbee           1   XL    ash                  (paid)
[SFL] Frank Olearczyk       1   L     ash                  (paid)
[SFL] Lou Miller            1   L     black                
[SFL] Ryan Bark             1   XL    black                
[SFL] John Alex Rodriguez   1   XL    ash                  
                            1   XL    black                
[SFL] Mick Weiss            2   L     black      
EOT

my $footer = <<EOT;
</pre>
EOT

# Print the plain text...
print "$header$shirts\n\n";

# Print a summary of shirt types...
print "\nSummary:\n";
foreach (split /\n/, $shirts) {
   ($qty, $size, $color) = (/(\d+) +(\w+) +(.*)/);
   $color =~ s/\(.*//g;    # Drop '(paid)'...
   $color =~ s/\s+$//;
   $summary{"$size $color"} += $qty;
   $total += $qty;
}
foreach (sort keys %summary) {
   print "$summary{$_} $_\n";
}
print "($total Total)";

print $footer;


