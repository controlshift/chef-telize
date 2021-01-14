chef-telize
===========

Chef cookbook for an nginx server doing IP geolocation using telize

Requirements
------------

This cookbook is known to work on Ubuntu 14.04 Trusty, 16.04 Xenial and 20.04 Focal.

Attributes
----------
* `node['telize']['lb_subnet']`  When calls come from this IP range, treat the X-Forwarded-For IP address as the client's IP address.  Used to make the service work when behind a load balancer.  Default value works for some Amazon Web Services ELBs.
* `node['telize']['ipv6?']`  When this is true, GeoIP databases that include both IPv6 and IPv4 will be used.  When it's false, IPv4-only databases will be used.  Default is true.

Usage
-----
Just include `telize` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[telize]"
  ]
}
```
