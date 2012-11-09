#!/usr/bin/perl 
#
# Our meetings are held the 2nd Tuesday of every month. Figure out when the next meeting is.
# Date::Calc, Class::Date rule!
# jay(at)jays(dot)net - Omaha Perl Mongers - http://omaha.pm.org

use Date::Calc  qw( Today Add_Delta_YM Nth_Weekday_of_Month_Year );
use Class::Date qw( date );

my @today          = Today();
my @next_month     = Add_Delta_YM(@today, 0, 1);
my $today          = ymd_to_obj(@today);
my $mtg_this_month = ymd_to_obj(Nth_Weekday_of_Month_Year(@today[0..1],      3, 2));  # 2nd Wednesday
my $mtg_next_month = ymd_to_obj(Nth_Weekday_of_Month_Year(@next_month[0..1], 3, 2));  # 2nd Wednesday

my $meeting_date = $mtg_this_month;
if ($today > $meeting_date) {
   $meeting_date = $mtg_next_month;
}

$Class::Date::DATE_FORMAT = "%a, %d %b %Y";
print "Content-type: text\n\n";
print "$meeting_date\n";

sub ymd_to_obj {
   # Given any $year, $month, $day return a Class::Date object.
   return date( sprintf("%04d-%02d-%02d", @_) );
}

