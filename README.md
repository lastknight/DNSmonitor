DNSmonitor by Matteo Flora <mf@matteoflora.com>

Copyright 2010 The Fool Srl.


DESCRIPTION
-----------

DNSmonitor is a very simple yet effective DNS monitoring utility, very useful in debugging what happens on DNS level on your hosts and/or your company. DNSmonitor can help you in looking at the underlying mechanics of what happens at DNS request/response level by providing you basic informations on the request and response objects.  
DNSmonitor uses pcap and is able to listen silently to the connetions, without need to set-up proxies or complicate environments.

QUICK START
-----------

For the impatient, please install required libs with `sudo gem install term-ansicolor dnsruby pcap`.  
To run the script `sudo ruby DNSmontor.rb`. Superuser is needed for Pcap integration. Your screen will show you something in the line of the following paragraph:

	www.lastknight.com.	IN	A || 87.118.111.215:53 || 1.0.239.147 || 46246
		www.lastknight.com.	120	IN	CNAME	lastknight.com.
		lastknight.com.	120	IN	A	70.32.68.103
	www.lastknight.com.	IN	AAAA || 87.118.111.215:53 || 1.0.239.147 || 16453
		www.lastknight.com.	120	IN	CNAME	lastknight.com.
	twitter.com.	IN	A || 87.118.111.215:53 || 1.0.239.147 || 47081
		twitter.com.	20	IN	A	128.242.240.84
		twitter.com.	20	IN	A	168.143.161.20
		twitter.com.	20	IN	A	168.143.171.180

The not indented lines are requests while indented ones are answers.

FOOLDNS INTEGRATION
-------------------

DNSmonitor is fully integrated with the [FoolDNS](http://www.fooldns.org) service and answers poisoned by FoolDNS are shown in yellow color.  
FoolDNS protect your computer and your LAN from behavioral profiling, malware and advertising.  Take a look :)

LOG FORMAT
----------

Every request is logged in the root directory of the application using Logger.

REQUIREMENTS
------------

* pcap
* pp
* term-ansicolor
* dnsruby

