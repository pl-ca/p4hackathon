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

# loss = net.pingAll()
# assert loss == 0

# Start the mininet CLI to interactively run commands in the network:
from mininet.cli import CLI
CLI(net)

print "OK"
