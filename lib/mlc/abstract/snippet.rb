module Mlc
  module Abstract
    class Snippet
      def initialize
        @children = []
      end

      def to_lua(opts = {})
        template = <<URMOM
(function (mlc)
  local _scope, self, _global, _const, _ = mlc.scope, mlc.top, mlc.global, mlc.const, mlc.helpers
LVARS
STUFF

end)(Mlc)
URMOM
        state = Mlc::ParserState.new
        (opts[:require] ? "local Mlc = require('mlc')\n" : '') +
          template.gsub('STUFF', @children.first.to_lua(1, opts, state)).
          gsub('LVARS', state.lvars.empty? ? '' : "\n  #{state.lvars_define}")

      end

      def <<(child)
        @children << child
      end
    end
  end
end