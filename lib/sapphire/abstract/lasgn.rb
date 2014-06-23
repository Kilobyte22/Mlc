module Sapphire
  module Abstract
    class LAsgn
      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_lua(indent, options, state)
        ret = "l#{@name.to_s} = #{@value.to_lua(indent + 1, options, state)}"
        state.add_lvar @name
        ret
      end
    end
  end
end