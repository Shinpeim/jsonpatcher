# JSONPatcher

jsonpatcher provides a DSL to patch semantically wrong JSON

## Installation

Add this line to your application's Gemfile:

    gem 'jsonpatcher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jsonpatcher

## Usage
    require 'jsonpatcher'

    # patch array
    bad_json = '["1","2","3"]' # (elements should be Number)
    patcher = JSONPatcher.new {
      array ->(element){ element.to_i }
    }
    p patcher.patch(bad_json) #=> [1, 2, 3]

    # patch object
    bad_json = '{"name":"shinpei","age":"28"}' # (age should be Number)
    patcher = JSONPatcher.new {
      object {
        property :age, ->(v){ v.to_i }
      }
    }
    p patcher.patch(bad_json) # => '{"name":"shinpei","age":28}'

    # patch array of objects
    bad_json = '[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]'
    patcher = JSONPatcher.new {
      array {
        object {
          property :age, ->(v){ v.to_i }
        }
      }
    }
    p patcher.patch(bad_json) # => '[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]'

    # patch nested object
    bad_json = '{"following":[{"name":"shinpei","age":"28"},{"name":"kosuge","age":"22"}]}'
    patcher = JSONPatcher.new {
      object {
        property (:following) {
          array {
            object {
              property :age, ->(v){ v.to_i }
            }
          }
        }
      }
    }
    p patcher.patch(bad_json) # => '{"following":[{"name":"shinpei","age":28},{"name":"kosuge","age":22}]}'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
