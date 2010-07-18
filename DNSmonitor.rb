# sudo gem install pcap
# sudo gem install dnsruby
require 'rubygems'
require 'pcaplet'
require 'dnsruby'
require 'pp'
require 'term/ansicolor'
include Term::ANSIColor

# If active shows responses part of the capture
$show_response = true
# If active enables logging
$is_development = false
$Logger = Logger.new('dns_capture.log', 'daily')

# Limit 
dump = Pcaplet.new('-s 1500 -i en1')

DNS_REQUEST   = Pcap::Filter.new('dst port 53', dump.capture)
DNS_RESPONSE  = Pcap::Filter.new('src port 53', dump.capture)

dump.add_filter(DNS_REQUEST | DNS_RESPONSE)

puts "starting!\n"

dump.each_packet {|pkt|
  data = pkt.udp_data
  case pkt
    when DNS_REQUEST
      if data 
        pp Dnsruby::Message.decode(data) if $is_development
      end
    when DNS_RESPONSE
      if data && $show_response
        path = $1
        host = pkt.dst.to_s
        source = pkt.src    # Source Address
        sport = pkt.sport   # Source Port

        q = Dnsruby::Message.decode(data).question
        qs = "#{q} || #{pkt.src}:#{pkt.sport} || #{host} || #{ Dnsruby::Message.decode(data).header.id}\n" 
        $Logger.info("#{qs}\t#{pkt.src}\t#{sport}")
        print red, qs, reset if qs

        a = Dnsruby::Message.decode(data).answer
        nx = Dnsruby::Message.decode(data).to_s.include?("NXDOMAIN")
        str = ""
        a.each do |c|
          str = str + "\t#{c.to_s}\n" if c.to_s.size > 10
        end
        s = "#{str}" if $show_response
        #s = s + " NX" if nx
        pp Dnsruby::Message.decode(data) if $is_development
  
        $Logger.info("#{str}\t#{pkt.src}\t#{pkt.sport}\t#{nx}")
        if s
          print white, s, reset if !s.include?("test.fool")
          print yellow, bold, s, reset if s.include?("test.fool")          
        end
      end
    end
}