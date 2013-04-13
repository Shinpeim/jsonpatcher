class JSONPatcher
  class DSL
    def self.parse(&block)
      parser = new
      parser.instance_eval &block
    end

    def object(&block)
      ObjectPatcher.new(ObjectDSL.parse &block)
    end

    def array(callable = nil, &block)
      if block_given?
        callable = ArrayDSL.parse &block
      else
        callable
      end
      ArrayPatcher.new(callable)
    end

    class ArrayDSL < self
    end

    class ObjectDSL < self
      def self.parse(&block)
        parser = new
        parser.instance_eval &block
        parser.instance_variable_get(:"@patcher")
      end

      def property(key, callable = nil, &block)
        if block_given?
          callable = DSL.parse(&block)
        end
        @patcher ||= {}
        @patcher[key] = callable
      end
    end
  end
end
