#!/usr/bin/perl
#///////////////////////////////////////////////////////////////////////////////
#/                        Coypright (C) Aviral Mittal.
#///////////////////////////////////////////////////////////////////////////////
#/   All rights reserved. Reproducion in whole or in part is prohibited without
#/   written consent of copyright Owner.The professional use of this material
#/   is subject to the copy right owners approval in written.
#///////////////////////////////////////////////////////////////////////////////
################################################################################
#This script can be used to generate random numbers between two integers
#To use this script, 
#unix> ./rand_gen <lower_limit> <upper_limit> <N>(optional) 'bin'(optional)
#'N' numbers will thus be generated, between 'lower_limit' and 'upper_limit'
#The default value of 'N' is 10.
# Example 1
# ./rand_gen.pl 0 8 4 bin
# The above command will generate 4 numbers between 0 and 8(both included)
# and since 'bin' is placed as a last input field, a 32 bit binary eq will
# also be generted along with the decimal value.
# Example 2
# ./rand_gen.pl 14 234 8000
# Example 3
# ./rand_gen.pl 8000 9876
################################################################################
if(@ARGV[0] eq "") {
print "ERROR: insufficient fields\n";
print "Usage:unix> ./rand_gen <lower_limit> <upper_limit> <N>(op) bin(op)\n";
print "'op' means optional\n";
print "Where 'N' is the number of random values needed which is optional\n";
print "Where 'bin' is also optional. if bin is present, a 32 bit \n";
print "binary eq will also be generated for each random value \n"; 
print "Example :  ./rand_gen.pl 0 8 4 bin \n"; 
exit;
}

if(@ARGV[1] eq "") {
print "ERROR: insufficient fields\n";
print "Usage:unix> \n";
exit;
}

if(@ARGV[2] eq "") {
  $c = 10;
}
else {
  $c = @ARGV[2];
}

#$random = int( rand(51)) + 25;
#$random = int( rand( $Y-$X+1 ) ) + $X;
#$random = int( rand(51)) + 25;
#25 and 75

$i = 0;

$a = @ARGV[0];
$b = @ARGV[1];
print @INC;


while($i < $c) {
  $lbitsx = int( rand($b - $a + 1)) + $a;
  print "$lbitsx";
  if( @ARGV[3] eq 'bin') {
  $bb = dec2bin($lbitsx);
  print " $bb";
  }
  print " \n";
  $i = $i + 1;
}

sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
    $len = length($str);
    $z = '0';
    while ($len < 32) {
      $len = $len + 1;
      $str = $z.$str;
    }

    return $str;
}
