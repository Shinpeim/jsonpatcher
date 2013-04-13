class JSONPatcher
  class ArrayPatcher
    def initialize(callable)
      @patcher = callable
    end

    def call(array)
      array.map{ |e| @patcher.call(e) }
    end
  end
end
