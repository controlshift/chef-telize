# Assume calls from this subnet are from our LB, so we should use the x-forwarded-for IP address
default['telize']['lb_subnet'] = '172.31.32.0/18'

# Should we support IPv6?
# Ubuntu 12.04's version of libgeoip can't handle ipv6, so this is false by default
default['telize']['ipv6?'] = false