chef-telize
===========

Chef cookbook for an nginx server doing IP geolocation using telize

Requirements
------------

This cookbook is known to work on Ubuntu 12.04 Precise and 14.04 Trusty.

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
