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

``` crystal
require 'pegasus'

parser = Pegasus::Parser.define do |p|
  p.rule(:add) { |p| p.rule(:mul).aka(:l) >> (p.rule(:addop) >> p.rule(:mul)).repeat(1) | p.rule(:mul) }

  p.rule(:mul) { |p| p.rule(:int).aka(:l) >> (p.rule(:mulop) >> p.rule(:int)).repeat(1) | p.rule(:int) }

  p.rule(:int) { |p| p.rule(:digit).repeat(1).aka(:i) >> p.rule(:space?) }

  p.rule(:addop) { |p| p.match(/+-/).aka(:o) >> p.rule(:space?) }

  p.rule(:mulop) { |p| p.match(/*\//).aka(:o) >> p.rule(:space?) }

  p.rule(:digit) { |p| p.match(/\d/) }

  p.rule(:space?) { |p| p.match(/\s*/).repeat }
end

parse_tree = parser.parse("1 + 2 - 3 * 5 / 2")
```


## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/pawandubey/pegasus/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [pawandubey](https://github.com/pawandubey) Pawan Dubey - creator, maintainer
