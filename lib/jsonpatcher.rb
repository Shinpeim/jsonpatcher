require "jsonpatcher/version"
require "jsonpatcher/dsl"
require "jsonpatcher/object_patcher"
require "jsonpatcher/array_patcher"
require "jsonpatcher/element_patcher"
require "json"
class JSONPatcher
  def initialize(&block)
    @patcher = DSL.parse &block
  end

  def patch(json)
    item = JSON.parse(json)
    patched = @patcher.call(item)
    patched.to_json
  end
end
