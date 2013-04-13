class JSONPatcher
  class ElementPatcher
    def initialize(&block)
      @patcher = block
    end

    def patch(element)
      @patcher.call(element)
    end
  end
end
