chef-telize
===========

Chef cookbook for an nginx server doing IP geolocation using telize

Requirements
------------

This is known to work on Ubunty 14.04 Trusty.  It should work on debian-based linuxes in general; hasn't been tested on other OSes.

Attributes
----------
Nothing configurable yet.

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
