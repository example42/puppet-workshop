# Multi Master

1. Last Verteilung
2. Netzwerk Separation

Generell:

Erster Puppet Master wird Master of Masters (MoM)

Weitere Puppet Compiler werden als Node vom MoM  konfiguriert.

Für Lastverteilung:

Compiler hinter Load Balancer.
Load Balancer DNS Name muss bei der Installation (!!) des MoM als DNS ALT NAME angegeben werden.
Load Balancer muss bei den Compilern als DNS ALT NAME angegeben werden.

Für Netzwerkseparierung:

Compile Master agiert als Proxy (CA, Reports, Node Klassifizierung).

Jeder Compile Master muss bei der Installation des MoM als DNS ALT NAME angegeben werden.

Zusätzliche Netzwerkzone = neue CA
