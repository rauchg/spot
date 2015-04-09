## spot(1)

Tiny ack-style file search utility.

### Features

* Short & written in Bash: you can edit it easily to suit your liking.
* Fast. Just `find` + `grep` + `awk`.
* Searches most things by default instead of some known predefined extensions.
* Ignores .git, .hg, .svn, devices and binary files.

### Usage

#### Smart phrases

All arguments constitute the search text. No need to wrap most searches
in double quotes.

![](https://cldup.com/TiVORMfp77-1200x1200.png)

#### Smart case

`spot` is case-insensitive by default. However, if your search term
contains an uppercase letter, it becomes sensitive!

![](https://cldup.com/EnapzH91cM-1200x1200.png)

#### Smart targets

If the first argument contains a slash _and_ is a valid directory, the
search is constrained to that particular target.

![](https://cldup.com/AQN2uflm8k-3000x3000.png)

#### Wildcard matching

In `spot(1)` searches, the `.` character acts as the RegExp wildcard,
making it very easy to perform searches that match anything, and to avoid
escaping characters or including ones that are not necessary for your
search.

![](https://cldup.com/YV-Q1_-0Lo-3000x3000.png)

#### Line abbrevation

If the line where matches are found is too long (such as minified source files),
`spot(1)` will only display the surrounding characters.

![](https://cldup.com/aeEUHlTJin-3000x3000.png)

#### Options

`spot -h` to see them.

### Installation

If you have NPM:

```
$ npm install -g spot
```

Or if you have [bpkg](https://github.com/bpkg/bpkg)

```
$ bpkg install -g rauchg/spot
```

You're done! Otherwise, run this command:

```
curl -L https://raw.github.com/rauchg/spot/master/spot.sh -o ~/bin/spot && chmod +x ~/bin/spot
```

If you don't have `~/bin`, replace it with another directory in your
`$PATH`, like `/usr/local/bin`.

### License

(The MIT License)

Copyright (c) 2014 Guillermo Rauch &lt;rauchg@gmail.com&gt;

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
