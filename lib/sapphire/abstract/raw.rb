module Sapphire
  module Abstract
    class Raw
      def initialize(text)
        @text = text
      end

      def to_lua(indent, options, state)
        @text
      end
    end
  end
end