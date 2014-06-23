module Mlc
  module Abstract
    class Const
      def initialize(name)
        @name = name
      end

      def to_lua(indent, options, state)
        "_const.#{@name}"
      end
    end
  end
end