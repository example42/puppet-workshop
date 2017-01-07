
node 'localhost' {
  # no classification, not default node
}

node default {
  notify { 'This node has no classification': }
}

node /^www\d\.example\.domain$/ {
  # all web servers: www1, www2, ...
}

node 'agent.domain.con' {
  contain hpi_demo_ntp
}


