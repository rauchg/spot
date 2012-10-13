
## spot(1)

Tiny ack-style file search utility.

### Features

* Short & written in Bash: you can edit it easily to suit your liking.
* Fast. Just `find` + `grep`.
* Searches most things by default instead of some known predefined extensions.
* Ignores .git, .svn, devices and binary files.

### Usage

#### Smart phrases

All arguments constitute the search text. No need to wrap most searches
in double quotes.

![](http://f.cl.ly/items/1Z063i0o3O2m0y2n0Q0d/Image%202012.03.04%2012:26:39%20PM.png)

#### Smart case

`spot` is case-insensitive by default. However, if your search term
contains an uppercase letter, it becomes sensitive!

![](http://f.cl.ly/items/2N332F0V302x1X47042c/Image%202012.03.04%2012:35:22%20PM.png)

#### Smart targets

If the first argument contains a slash _and_ is a valid directory, the
search is constrained to that particular target.

![](http://f.cl.ly/items/2u3x3T3j0B0q3s0T310t/Image%202012.03.04%2012:40:08%20PM.png)

#### Wildcard matching

In `spot(1)` searches, the `.` character acts as the RegExp wildcard,
making it very easy to perform searches that match anything, and to avoid
escaping characters or including ones that are not necessary for your
search.

#### Options

`spot -h` to see them.

### Installation

Run this command:

```
curl https://raw.github.com/guille/spot/master/spot.sh -o ~/bin/spot && chmod +x ~/bin/spot
```

If you don't have `~/bin`, replace it with another directory in your
`$PATH`, like `/usr/local/bin`.

### License

(The MIT License)

Copyright (c) 2011 Guillermo Rauch &lt;guillermo@learnboost.com&gt;

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
