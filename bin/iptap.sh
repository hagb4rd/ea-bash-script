#!/bin/bash

# Set to the name of your bridge
BRIDGE=br0

# Network information
NETWORK=10.0.0.0/8
NETMASK=255.0.0.0
GATEWAY=10.2.0.1
DHCPRANGE=10.2.0.2,10.2.0.254

# Optionally parameters to enable PXE support
TFTPROOT=
BOOTP=

# 
i='iptables'

# Policy
$i -P INPUT DROP 
$i -P OUTPUT DROP
$i -P FORWARD DROP

# Reset der Regeln: 
$i -F
$i -X 
$i -Z


# Erlaubt Loopback-Verbindungen: 
$i -A INPUT -i lo -j ACCEPT 
$i -A OUTPUT -o lo -j ACCEPT

# Bestehende Verbindung erlauben: 
$i -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT 
$i -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

$i -A INPUT -i br0 -p tcp -m tcp --dport 67 -j ACCEPT 
$i -A INPUT -i br0 -p udp -m udp --dport 67 -j ACCEPT 
$i -A INPUT -i br0 -p tcp -m tcp --dport 53 -j ACCEPT 
$i -A INPUT -i br0 -p udp -m udp --dport 53 -j ACCEPT 

# Ping erlauben: 
$i -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT 
$i -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT 
$i -A INPUT -p icmp --icmp-type echo-request -j ACCEPT 
$i -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
# Blockiert typische Portscans: 
$i -N PORTSCAN 
$i -A PORTSCAN -p tcp --tcp-flags ACK,FIN FIN -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ACK,PSH PSH -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ACK,URG URG -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ALL ALL -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ALL NONE -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags FIN,RST FIN,RST -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags SYN,RST SYN,RST -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP 
$i -A PORTSCAN -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
$i -A INPUT -p tcp -j PORTSCAN
# Blockiert fragmentierte Pakete: 
$i -A INPUT -f -j DROP
# SYN-Pakete erlauben: 
$i -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
# Öffnet ausgehene Ports (DNS): 
# Stoppt SYN-Floods 
$i -N SYNFLOOD 
$i -A SYNFLOOD -p tcp --syn -m limit --limit 40/s -j RETURN 
$i -A SYNFLOOD -p tcp -j REJECT --reject-with tcp-reset 
$i -A INPUT -p tcp -m state --state NEW -j SYNFLOOD



#$i -A OUTPUT -j ACCEPT
$i -A OUTPUT -p udp --dport 53 -j ACCEPT
$i -A OUTPUT -p tcp --dport 53 -j ACCEPT
$i -A OUTPUT -p tcp --dport 67 -j ACCEPT
$i -A OUTPUT -p udp --dport 67 -j ACCEPT
$i -A OUTPUT -p tcp --dport 80 -j ACCEPT
#$i -A OUTPUT -p tcp --dport 21 -j ACCEPT
$i -A OUTPUT -p tcp --dport 443 -j ACCEPT
#$i -A OUTPUT -p tcp --dport 43 -j ACCEPT
#$i -A OUTPUT -p udp --dport 43 -j ACCEPT
$i -A OUTPUT -p tcp --dport 6697 -j ACCEPT
$i -A OUTPUT -p tcp --dport 9001 -j ACCEPT
#$i -A OUTPUT -p tcp --dport 8443 -j ACCEPT
# Öffnet eingehenden TCP-Port 22 (SSH): 
# $i -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT 
# $i -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

$i -A FORWARD -i tap0 -o tap0 -j ACCEPT 
$i -A FORWARD -s $NETWORK/$NETMASK -i br0 -j ACCEPT 
$i -A FORWARD -d $NETWORK/$NETMASK -o br0 -m state --state RELATED,ESTABLISHED -j ACCEPT 
$i -A FORWARD -o br0 -j REJECT --reject-with icmp-port-unreachable 
$i -A FORWARD -i br0 -j REJECT --reject-with icmp-port-unreachable 

# Verwirft alle unerlaubten Pakete 
$i -A INPUT -j DROP  
$i -A FORWARD -j DROP 
$i -A OUTPUT -j DROP 



i='iptables -t nat'
$i -F
$i -X
$i -A PREROUTING -d $NETWORK/$NETMASK -i br0 -j DNAT --redirect-to $GATEWAY  

$i -A POSTROUTING -s $NETWORK/$NETMASK -j MASQUERADE
$i -A POSTROUTING -o $dev -j MASQUERADE


i='ip6tables'

# Policy
$i -P INPUT DROP 
$i -P OUTPUT DROP
$i -P FORWARD DROP

# Reset der Regeln: 
$i -F
$i -X 
$i -Z

$i -A INPUT -j REJECT
$i -A FORWARD -j REJECT 
$i -A OUTPUT -j REJECT
