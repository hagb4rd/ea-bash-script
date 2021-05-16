ifconfig $dev down
dhclient -r $dev
ifconfig $dev up && dhclient -v $dev
echo nameserver $dns1 > /etc/resolv.conf
echo nameserver $dns2 >> /etc/resolv.conf
