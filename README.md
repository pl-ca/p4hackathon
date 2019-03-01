# intro
We want to implement the dynamic programming algorithm to

# architecture

- headers:
  - string 1
  - string 2
  - matrix
  - z
  - longest

# Constraints

- stage1: 2 8 byte strings, 64 byte matrix

# Tools

- p4 runtime: run module directly, avoid compelxity of mininet
- scapy: set input packet to runtime

# Recirculation:

Recirculation happens at the end of the packet pipeline, causing it to be re-parsed after deparsing.  
During ingress processing, it must be sent to PSA_PORT_RECIRCULATE  

extern void recirculate<T>(in T x);
bit<16> recirculate_port;
bit<32> recirculate_flag;

for v1model, this is accomplished with the method recirculate(meta)

# instructions
in two windows, do make run, and make h1  
in the make h1 window, use scapy, and run: send(IP(dst="1.2.3.4")/ICMP())

to text external packet  
scapy: sendp('\x00' + 'A1234567' + 'B1234567')

to text internal packet  
scapy: sendp('\x01' + 'A1234567' + 'B1234567')

to test reject packet  
scapy: sendp('\x02' + 'A1234567' + 'B1234567')