[![Build Status](https://travis-ci.org/pawandubey/pegasus.svg)](https://travis-ci.org/pawandubey/pegasus)

# pegasus

A PEG parser library for Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  pegasus:
    github: pawandubey/pegasus
```

## Usage

Let's look at a simple example for a URL query parser that can accept:
- an optional `&` at the end of the query
- an optional `=` at the end of the query

``` crystal
require "pegasus"

parser = Pegasus::Parser.define do |p|
  p.rule(:query) do |p| # complex base rule with alternatives, repetition and optional occurence
    (p.rule(:pair) >> p.rule(:sep) >> p.rule(:pair).maybe?).repeat | p.rule(:pair)
  end

  p.rule(:pair) { |p| p.rule(:str).aka(:key) >> p.str("=") >> p.rule(:str).aka(:val).maybe? }

  p.rule(:sep) { |p| p.str("&").aka(:sep) } #=> rename nodes with .aka
  p.rule(:str) { |p| p.match(/\A[^\s\/\\\.&=]+/) } #=> use regex wherever it makes sense

  p.root(:query)
end

res = parser.parse("name=ferret&color=purple") # get back the parse result
#=> #<Pegasus::MatchResult:0x1e418e0>

res.success? # find if parse was successful
#=> true

parse_tree = res.parse_tree # get the parse tree
#=> #<Pegasus::ParseTree:0x1e418c0>

parse_tree.dump # dump the parse tree to JSON
#=> {"label":"rep","children":[{"label":"seq","children":[{"label":"seq","children":[{"label":"seq","children":[{"label":"seq","children":[{"label":"key","item":"name"},{"label":"terminal","item":"="}]},{"label":"rep","children":[{"label":"val","item":"ferret"}]}]},{"label":"sep","item":"&"}]},{"label":"rep","children":[{"label":"seq","children":[{"label":"seq","children":[{"label":"key","item":"color"},{"label":"terminal","item":"="}]},{"label":"rep","children":[{"label":"val","item":"purple"}]}]}]}]}]}


```

For a more complex (and standard) example:

``` crystal
# simple calculator example

require "pegasus"

parser = Pegasus::Parser.define do |p|
  p.rule(:add) do |p|
    p.rule(:mul).aka(:l) >> (p.rule(:addop) >> p.rule(:mul)).repeat | p.rule(:mul)
  end

  p.rule(:mul) do |p|
    p.rule(:int).aka(:l) >> (p.rule(:mulop) >> p.rule(:int)).repeat | p.rule(:int)
  end

  p.rule(:int) do |p|
    p.rule(:digit).aka(:i) >> p.rule(:space?).ignore
  end

  p.rule(:addop) { |p| p.match(/\A[\+\-]/).aka(:o) >> p.rule(:space?).ignore }
  p.rule(:mulop) { |p| p.match(/\A[\*\/]/).aka(:o) >> p.rule(:space?).ignore }
  p.rule(:digit) { |p| p.match(/\A\d+/) }
  p.rule(:space?) { |p| p.match(/\A\s*/) }

  p.root(:add) # define root node to start the parse from
end

res = parser.parse("0-1 + 2 /4 * 51 ")

res.success? #=> true
```

## Contributing

1. Fork it ( https://github.com/pawandubey/pegasus/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [pawandubey](https://github.com/pawandubey) Pawan Dubey - creator, maintainer
