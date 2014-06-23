module Sapphire
  module Abstract
    class Block
      def initialize
        @children = []
      end

      def <<(child)
        @children << child
      end

      def to_lua(indent, options, state)
        i = '  ' * indent
        i + @children.map {|el| el.to_lua(indent + 1, options, state)}.join("\n#{i}")
      end
    end
  end
end