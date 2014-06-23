module Sapphire
  module Abstract
    class LVar
      def initialize(name)
        @name = name
      end

      def to_lua(indent, options, state)
        "l#{@name.to_s}"
      end
    end
  end
end