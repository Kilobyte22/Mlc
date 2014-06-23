module Sapphire
  module Abstract
    class Snippet
      def initialize
        @children = []
      end

      def to_lua(opts = {})
        template = <<URMOM
(function (sapphire)
  local _scope, _global, _const, _ = sapphire.scope, sapphire.global, sapphire.const, sapphire.helpers
LVARS
STUFF

end)(Sapphire)
URMOM
        state = Sapphire::ParserState.new
        (opts[:require] ? "local Sapphire = require('sapphire')\n" : '') +
          template.gsub('STUFF', @children.first.to_lua(1, opts, state)).
          gsub('LVARS', state.lvars.empty? ? '' : "\n  #{state.lvars_define}")

      end

      def <<(child)
        @children << child
      end
    end
  end
end