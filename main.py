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
<<<<<<< HEAD
#sw.insertTableEntry(table_name='MyIngress.test_table',
#                    match_fields={'hdr.type_header.input_or_internal': 'A'},
#                    action_name='MyIngress.test_action',
#                    action_params={'port': 2}
#                    )
=======

for i in range(0,7):
    sw.insertTableEntry(table_name='MyIngress.get_strA_char',
                        match_fields={'meta.strA_idx': i},
                        action_name='MyIngress.get_strA_char'+str(i)
                        )

for i in range(0,7):
    sw.insertTableEntry(table_name='MyIngress.get_strB_char',
                        match_fields={'meta.strB_idx': i},
                        action_name='MyIngress.get_strB_char'+str(i)
                        )
>>>>>>> c52c0b4d3853105a5bdf68111a625bde5d3d6949



from mininet.cli import CLI
CLI(net)

print "OK"
