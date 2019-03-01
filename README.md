#README.md

architecture
    headers:
        string 1
        string 2
        matrix
        z
        longest

Constraints
    stage1: 2 8 byte strings, 64 byte matrix

Tools
    p4 runtime: run module directly, avoid compelxity of mininet
    scapy: set input packet to runtime