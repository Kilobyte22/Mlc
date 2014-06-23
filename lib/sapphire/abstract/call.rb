module Sapphire
  module Abstract
    class Call
      attr_accessor :object, :name
      attr_reader :args
      def initialize
        @args = []
      end

      def to_lua(indent, options, state)
        obj = @object.to_lua(indent + 1, options, state)
        args = @args.dup.unshift Raw.new('nil')
        name = "m#{@name}"
        if name =~ /^[A-Za-z][A-Za-z0-1_]*$/
          "#{obj}:#{name}#{Sapphire.prepare_args(indent, options, state, args)}"
        else
          args.unshift Raw.new("'#{Sapphire.escape_str(name)}'")
          "#{obj}:_call#{Sapphire.prepare_args(indent, options, state, args)}"
        end
      end
    end
  end
end