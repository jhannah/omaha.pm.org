#!/usr/bin/perl

my $header .= <<EOT;
Content-type: text

<pre>
Who                        Qty  Size  Color
-------------------------- ---  ----  ----------------
EOT

my $shirts = <<EOT;
[ABE] Ricardo Signes        2   XL    black
                            1   XL    ash
                            1   L     black
                            1   L     ash
                            2   M     black
                            1   M     ash
[ATL] Les Howard            1   L     ash
                            1   L     black
[ATL] Elliot Holden         1   L     ash
                            1   L     black
[ATL] Simon Welper          1   2XL   black
[ATL] Alan Fausel           1   2XL   black
[ATL] Christopher Fowler    2   L     black
[ATL] Russ Thomas           1   XL    black
                            1   XL    ash
[ATL] Rob Osattin           1   3XL   ash
                            1   3XL   black
[ATL] Rob Elsworth          1   3XL   ash
                            1   3XL   black
[AUS] Chris Connally        1   4XL   black                paid \$25
                            1   4XL   ash
[BRA] Jeremy Fluhmann       1   2XL   black
                            1   L     black
[DC] Zak Zebrowski          2   M     ash
                            1   L     black
                            1   L     ash
                            1   XL    black
                            2   XL    ash
                            1   2XL   black
                            1   2XL   ash
[ERL] Richard Lippmann     10   2XL   black
                           10   2XL   ash
                            5   XL    black
                            5   XL    ash
                            5   L     black
[HOU] G. Wade Johnson       3   XL    black
                            1   S     black
                            1   M     black
                            2   XL    ash
[ISR] Gabor Szabo           3   2XL   black
                            4   2XL   ash
                            1   XL    ash
                            1   XL    black
                            1   L     black
                            1   M     black
[OMA] Jay Hannah            1   2XL   black                paid
                            2   2XL   ash                  paid
[OMA] Trey Bianchini        2   2XL   ash
[OMA] Dave M                1   2XL   black
[OMA] Herb Wolfe, Jr.       1   XL    ash
EOT

my $footer = <<EOT;
</pre>
EOT

# Print the plain text...
print "$header$shirts\n\n";

# Print a summary of shirt types...
print "\nSummary:\n";
foreach (split /\n/, $shirts) {
   ($qty, $size, $color) = (/(\d+) +(\w+) +(\w+)/);
   $summary{"$size $color"} += $qty;
   $total += $qty;
}
foreach (sort keys %summary) {
   print "$summary{$_} $_\n";
}
print "($total Total)";

print $footer;


