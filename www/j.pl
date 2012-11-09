use Date::Manip;

my $next_month = 
   UnixDate(DateCalc(ParseDate("1st"), "+ 1 month"), "%b %Y");

print ParseDate("2nd Tuesday of $next_month");
print "\n";


