#!/usr/bin/perl

use strict;
use XML::Twig;

my $twig=XML::Twig->new();
$twig->parsefile('2006.xml');
my $root= $twig->root;

# These prices based on ordering 367 total shirts in August 2006.
# Prices about $0.50 higher at 48+ quantity... hmmm...
my %prices = (
   ash => { 
      '4XL' => 10.45,
      '3XL' => 8.95,
      '2XL' => 8.15,
      'XL'  => 5.95,
      'L'   => 5.95,
      'M'   => 5.95,
      'S'   => 5.95,
   },
   black => {
      '4XL' => 11.10,
      '3XL' => 9.50,
      '2XL' => 8.75,
      'XL'  => 6.65, 
      'L'   => 6.65, 
      'M'   => 6.65, 
      'S'   => 6.65,
   }
);

my $divider = "-" x 28 . "\n";

open (INV,  ">invoices.txt");
open (PROD, ">production.txt");
open (SHIP, ">shipping.txt");

my $disclaimer = <<EOT;
-----------------------------------------------------------------------
DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT
       This is a work in progress....
DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT DRAFT
-----------------------------------------------------------------------
EOT
$disclaimer = <<EOT;
-----------------------------------------------------------------------
FINAL. All quantities and colors were locked in on 2006-09-04.
-----------------------------------------------------------------------
EOT

print INV  $disclaimer;
print PROD $disclaimer;
print SHIP $disclaimer;

print PROD <<EOT;

This is the production report that will go to the printer...

EOT
print SHIP <<EOT;

This is the shipping report that will go to the shipper...

EOT
print INV  <<EOT;

This is the invoice report that will tell group leaders how much they need to pay Jay
so that he can place the order... It'll list shirts cost calculations, shipping 
estimate, PayPal overhead, payments received, total due...

EOT

my %production;   # Overall stats
my %grand_totals;
foreach my $shipto ($root->children('shipto')) {
   my $USzip = $shipto->att('USzip');

   print SHIP $divider;
   print SHIP mailing_address($shipto);
   print SHIP $divider;
   print INV $divider;
   print INV mailing_address($shipto);
   print INV $divider;

   # --------------
   # The printer only cares about each shipto, but group leaders might care
   # about contact names for each shirts entry... That's why we have 2 loops here.
   my (%this_shipto, $subtotal, $total_qty);
   foreach my $shirts ($shipto->children('shirts')) {
      my $qty     = $shirts->att('qty');
      my $size    = $shirts->att('size');
      my $color   = $shirts->att('color');
      my $contact = $shirts->att('contact');  # Optional contact name
      $total_qty += $qty;
      $production{$color}{$size} += $qty;
      $this_shipto{$color}{$size} += $qty;
      my $price = $prices{$color}{$size} * $qty;
      my $pricestr = sprintf("%0.2f", $price);
      printf INV (
         "%-4s %-6s %-8s \$%6s    %-20s\n", 
         $qty, $size, $color, $pricestr, $contact
      );
      $subtotal += $price;
      $grand_totals{price} += $price;
   } 
   my ($color, $size);
   foreach $color (keys %this_shipto) {
      foreach $size (keys %{$this_shipto{$color}}) {
         my $qty = $this_shipto{$color}{$size};
         print SHIP detail_line2($qty, $size, $color);
      }
   }
   print INV $divider;
   my $totaldue = $subtotal;
   $subtotal = sprintf("%0.2f", $subtotal);
   printf INV ("           Subtotal  \$%6s\n", $subtotal);

   if ($shipto->first_child('shipping')) {
      # We know what the actual shipping cost was.
      my $shipping_act = $shipto->first_child('shipping')->att('actual');
      $totaldue += $shipping_act;
      $grand_totals{shipping_act} += $shipping_act;
      $shipping_act = sprintf("%0.2f", $shipping_act);
      printf INV ("      Shipping act.  \$%6s\n", $shipping_act);
   } else {
      # We're going to try to estimate what the shipping cost will be
      # ---
      # Cheesy domestic UPS shipping cost research...
      # 01566 -> 18018(PA) 10  pounds UPS Ground = $7.56
      # 01566 -> 18018(PA) 100 pounds UPS Ground = $71.09
      # 01566 -> 92121(CA) 10  pounds UPS Ground = $12.82
      # 01566 -> 92121(CA) 100 pounds UPS Ground = $84.22
      # ---
      # 10 shirts weighs 7 pounds, so each shirt weighs 0.7 pounds.
      # Lowest possible shipping: $13.
      # $10 for each 10 pounds. So $1 per pound.
      # ---
      # Actual costs we incurred:
      # Who                       Qty  Shirts  Shipping
      # Adam Clarke, Australia    20   $128    $202
      # Gabor Szabo, Israel       24   $180    $225
      # Joel Pinckheard, Spain    17   $107    $215
      # Richard Lippman, Germany  82   $600    $308
      # Jonas B. Nielsen, Denmark  8   $54     $140
      # Michele Beltrame, Italy    8   $52     $120
      # ---
      my $weight = $total_qty * 0.7;
      my $shipping_est = $weight;    # Shipping estimates
      if ($shipping_est < 13) {
         $shipping_est = 13;
      }
      $totaldue += $shipping_est;
      $grand_totals{shipping_est} += $shipping_est;
      $shipping_est = sprintf("%0.2f", $shipping_est);
      printf INV ("      Shipping est.  \$%6s  (WARNING: OVERSEAS COSTS \$100-\$300)\n", $shipping_est);
   }

   if ($shipto->children('paypal')) {
      # We have actual Paypal fees. Show those.
      my $paypal_act;
      foreach my $paypal ($shipto->children('paypal')) {
         my $this_act = $paypal->att('actual');
         $paypal_act += $this_act;
         $totaldue += $this_act;
         $grand_totals{paypal_act} += $this_act;
      }
      $paypal_act = sprintf("%0.2f", $paypal_act);
      printf INV ("        PayPal act.  \$%6s\n", $paypal_act);
   } else {
      # Estimate what the PayPal will probably be...
      # ----
      # Wow. wacky fee structure. The domestic fee I'm paying is 2.9% + 0.30.
      # https://www.paypal.com/us/cgi-bin/webscr?cmd=_display-receiving-fees
      my $paypal_est = ($totaldue * 0.029) + .3;
      $totaldue += $paypal_est;
      $grand_totals{paypal_est} += $paypal_est;
      $paypal_est = sprintf("%0.2f", $paypal_est);
      printf INV ("        PayPal est.  \$%6s\n", $paypal_est);
   }

   my ($total_paid, $paid_str) = payments($shipto);
   $totaldue -= $total_paid;
   $grand_totals{total_paid} += $total_paid;
   print INV $paid_str;

   $totaldue = sprintf("%0.2f", $totaldue);
   printf INV ("          Total Due  \$%6s USD\n", $totaldue);

   # --------------
   print SHIP $divider;
   print SHIP "\n\n";
   print INV "\n\n";

}

# ----------------------
# Kick out the production.txt report...
# ----------------------
my @sizes = qw( 4XL 3XL 2XL XL L M S );
my ($color, $size, $qty, $grand_total, $grand_qty);
foreach $color (keys %production) {
   foreach $size (@sizes) {
      $qty = $production{$color}{$size};
      $grand_qty += $qty;
      my $price = $prices{$color}{$size} * $qty;
      $grand_total += $price;
      my $pricestr = sprintf("%0.2f", $price);
      printf PROD (
         "%-4s %-6s %-8s                     \$ %7s\n",
         $qty, $size, $color, $pricestr
      );
   }
   print PROD "\n";
}
print PROD "\n\n";
$grand_total = sprintf("%0.2f", $grand_total);
print PROD "Grand total: $grand_qty shirts ($grand_total)";
# ----------------------

# ----------------------
# Kick out grand totals on the bottom of the invoices.txt report
# so I don't have to hire 5 accountants... 
# ----------------------
$grand_totals{total_paid} = 0 - $grand_totals{total_paid};
$grand_totals{total_due} = 
   $grand_totals{price} +
   $grand_totals{shipping_act} +
   $grand_totals{paypal_act} +
   $grand_totals{total_paid};
foreach my $key (keys %grand_totals) {
   $grand_totals{$key} = sprintf("%0.2f", $grand_totals{$key});
   $grand_totals{$key} = sprintf("%8s", $grand_totals{$key});
}
my $jays_wallet = sprintf("%0.2f", 
   -4209.45 + 43.06 - $grand_totals{total_paid} - $grand_totals{paypal_act} - 128.11
);
print INV <<EOT;

   GRAND TOTALS
       Price            \$ $grand_totals{price}
       Shipping est.    \$ $grand_totals{shipping_est}
       Shipping act.    \$ $grand_totals{shipping_act}
       PayPal est.      \$ $grand_totals{paypal_est}
       PayPal act.      \$ $grand_totals{paypal_act}
       Total paid       \$ $grand_totals{total_paid}
       Total due        \$ $grand_totals{total_due}


   Jay's wallet:
       -4209.45   payment to shirt company
         +43.06   Omaha "Total Due" is Jay's problem :)
                  + Total paid above
                  - PayPal act. above
        -128.11   donation to Perl Foundation
       --------
           $jays_wallet

EOT
# ----------------------


exit;


# -------
# END MAIN


  
sub mailing_address {
   my ($shipto) = @_;
   my $name = $shipto->att('name');
   my $phone = $shipto->att('phone');
   my $address = $shipto->first_child('address')->text;
   $address =~ s/^\n//;
   $address =~ s/  +//sg;
   chomp $address;
   my $ret = <<EOT;
$name
$address
EOT
   $ret .= "Phone: $phone\n" if ($phone);
   return $ret;
}

sub detail_line2 {
 #  my ($qty, $size, $color, $contact) = @_;
   return sprintf("%-4s %-6s %-8s %-20s\n", @_);
}

sub payments {
   my ($shipto) = @_;
   my $total_paid = 0;
   my $str;
   foreach my $payment ($shipto->children('payment')) {
      my $amount  = $payment->att('amount');
      my $contact = $payment->att('contact');
      my $amountstr = sprintf("%0.2f", $amount);
      #print "[$amount][$contact]\n";
      $str .= sprintf("            payment -\$%6s    %-20s\n", $amountstr, $contact);
      $total_paid += $amount;
   }
   return ($total_paid, $str);
}




