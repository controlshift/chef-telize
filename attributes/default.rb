# Assume calls from this subnet are from our LB, so we should use the x-forwarded-for IP address
default['telize']['lb_subnet'] = '172.31.32.0/18'
