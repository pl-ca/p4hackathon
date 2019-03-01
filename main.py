import sys
from p4app import P4Mininet, P4Program
from mininet.topo import Topo
from mininet.cli import CLI
from p4app import P4Mininet
from mininet.topo import SingleSwitchTopo

if len(sys.argv) > 1:
    if sys.argv[1] == 'compile':
        try:
            P4Program('substring_match.p4').compile()
        except Exception as e:
            print(e)
            sys.exit(1)
        sys.exit(0)


topo = SingleSwitchTopo(1)
net = P4Mininet(program='substring_match.p4', topo=topo)
net.start()



sw = net.get('s1')

for i in range(0,8):
    sw.insertTableEntry(table_name='MyIngress.get_strA_char',
                        match_fields={'hdr.internal_header.iterator_r': i},
                        action_name='MyIngress.get_strA_char'+str(i)
                        )

for i in range(0,8):
    sw.insertTableEntry(table_name='MyIngress.get_strB_char',
                        match_fields={'hdr.internal_header.iterator_l': i},
                        action_name='MyIngress.get_strB_char'+str(i)
                        )



from mininet.cli import CLI
CLI(net)

print "OK"
