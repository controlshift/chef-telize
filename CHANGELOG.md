telize CHANGELOG
================

This file is used to list changes made in each version of the telize cookbook.

2.1.1
-----
Fix for cmake finding pkg-config

2.1.0
-----
Rewrite for the current version of Telize

1.0.0
-----
Use built-in packages for lua modules. Drop support for Ubuntu 12.04

0.4.1
-----
- Fix permissions so that nginx can see cjson

0.4.0
-----
- Use the x-forwarded-for header to get the client's IP address when behind a load balancer
- Make IPv4-only vs. support-IPv6-too configurable

0.3.0
-----
Changes so that this cookbook stands alone without requiring the nginx cookbook
- Start nginx at the end of the telize::default recipe
- Disable the default nginx server

0.2.0
-----
Changes for compatibility with Ubuntu 12.04:
- Change lua-cjson install method
- Use IPv4-only GeoIP databases

0.1.0
-----
- [your_name] - Initial release of telize

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
