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
# simple calculator example

require "pegasus"

parser = Pegasus::Parser.define do |p|
  p.rule(:add) do |p|
    p.rule(:mul).aka(:l) >> (p.rule(:addop) >> p.rule(:mul)).repeat(1, 100) | p.rule(:mul)
  end

  p.rule(:mul) do |p|
    p.rule(:int).aka(:l) >> (p.rule(:mulop) >> p.rule(:int)).repeat(1, 100) | p.rule(:int)
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
