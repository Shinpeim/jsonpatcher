require "json-fixman/version"
require "json"
module JSON
  class Fixman
    def initialize(&block)
      self.instance_eval &block
    end
    def fix(json)
      item = JSON.parse(json)
      fixed = @fixer.fix(item)
      fixed.to_json
    end

    private
    #mthods for DSL
    def object(&block)
      @fixer = Dictionary.new &block
    end
    def array(&block)
      @fixer = Array.new &block
    end
    def process(&block)
      @fixer = Process.new &block
    end

    class Process < self
      def initialize(&block)
        @processor = block
      end
      def fix(item)
        @processor.call(item)
      end
    end

    class Array < self
      def fix(arr)
        fixed = []
        arr.each do |e|
          fixed.push @fixer.fix(e)
        end
        fixed
      end
    end

    class Dictionary < self
      def fix(hash)
        fixed = {}
        hash.each do |k,v|
          fixer = @fixers[k]
          if fixer
            fixed[k] = fixer.fix(v)
          else
            fixed[k] = v
          end
        end
        fixed
      end

      private
      #method for DSL
      def key(key,fixer)
        @fixers ||= {}
        @fixers[key.to_s] = fixer
      end
    end

  end
end
