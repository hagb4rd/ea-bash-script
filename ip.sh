#!/bin/bash
# 
i='iptables'

# Policy
$i -P INPUT DROP 
$i -P OUTPUT DROP
$i -P FORWARD ACCEPT

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
# Stoppt SYN-Floods 
$i -N SYNFLOOD 
$i -A SYNFLOOD -p tcp --syn -m limit --limit 40/s -j RETURN 
$i -A SYNFLOOD -p tcp -j REJECT --reject-with tcp-reset 
$i -A INPUT -p tcp -m state --state NEW -j SYNFLOOD
# Blockiert fragmentierte Pakete: 
$i -A INPUT -f -j DROP
# SYN-Pakete erlauben: 
$i -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
# Öffnet ausgehene Ports (DNS): 
#$i -A OUTPUT -j ACCEPT
$i -A OUTPUT -p udp -j ACCEPT
#$i -A OUTPUT -p all --dport 67 -j ACCEPT
#$i -A OUTPUT -p tcp --dport 80 -j ACCEPT
$i -A OUTPUT -p tcp -j ACCEPT
$i -A OUTPUT -p tcp --dport 6697 -j ACCEPT
#$i -A OUTPUT -p tcp --dport 8443 -j ACCEPT
# Öffnet eingehenden TCP-Port 22 (SSH): 
# $i -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT 
# $i -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
# Verwirft alle unerlaubten Pakete 
$i -A INPUT -j DROP  
#$i -A FORWARD -j DROP 
$i -A OUTPUT -j DROP 


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
