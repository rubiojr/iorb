= iorb

* http://rubiojr.github.com/

== DESCRIPTION:

http://drop.io CLI interface

You will need a drop.io API key. Get it at http://api.drop.io

== FEATURES/PROBLEMS:

* Many things not yet implemented

== SYNOPSIS:

=== Creating drops
  iorb create [drop_name]

=== Adding assets to a drop
 * Add files to an existing drop
 iorb add --drop-name <drop_name>  file1 file2 ...

 * create a random drop and add files to it
  iorb add file1 file2 ...

=== Listing assets
 * list all assets from a drop
  iorb list <drop_name>
 * list assets matching regex
  iorb list <drop_name> --filter '-(mov|mp3)'
 * list assets matching type
  iorb list <drop_name> --filter type:audio

=== Destroying drops/assets
 * destroy a drop
  iorb destroy <drop_name>
 * destroy all assets matching pattern from drop 'test_drop'
  iorb destroy test_drop:/-(mp3|avi)/
 * destroy all assets from test_drop
  iorb destroy test_drop:/.*/

== REQUIREMENTS:

* dropio ruby library from Jake Good:
  http://github.com/whoisjake/dropio_api_ruby/tree/master
* highline from James Edward Gray II:
  http://rubyforge.org/projects/highline
* commander from TJ Holowaych:
  http://github.com/visionmedia/commander

== INSTALL:

1. gem source -a http://gems.github.com
2. gem source -a http://iorb.netcorex.org (stable release)
   OR
   gem source -a http://dev.netcorex.org (unstable release)
3. gem install iorb

== LICENSE:

(The MIT License)

Copyright (c) 2009 Sergio Rubio <sergio@rubio.name>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
