class JSONPatcher
  class ObjectPatcher
    def initialize(callables)
      @patcher = callables
    end

    def call(hash)
      patched = {}
      hash.each do |k, v|
        patcher = @patcher[k.to_sym]
        if patcher
          patched[k] = patcher.call(v)
        else
          patched[k] = v
        end
      end
      patched
    end
  end
end
