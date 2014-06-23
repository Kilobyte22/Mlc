module Mlc
  module Abstract
    class Literal
      def initialize(value)
        @value = value
      end

      def to_lua(indent, options, state)
        if @value.is_a? Symbol
          "_.sym('#{Mlc.escape_str(@value.to_s)}')"
        elsif @value.is_a? String
          "_.wrap('#{Mlc.escape_str(@value)}')"
        else
          "_.wrap(#{@value.to_s})"
        end
      end
    end
  end
end