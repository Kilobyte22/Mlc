module Mlc
  class ParserState

    attr_reader :parent, :lvars

    def initialize(parent = nil, inherit = true)
      @tmpid = -1
      @lvars = []
      @parent = parent
      @inherit = inherit
    end

    def tmpvar
      "__tmp_#{@tmpid += 1}"
    end

    def add_lvar(name)
      unless knows_lvar? name
        @lvars << name
      end
    end

    def knows_lvar?(name)
      @lvars.include? name || (@inherit && @parent && @parent.knows_lvar?(name))
    end

    def lvars_define
      @lvars.map{|el| 'l' + el.to_s}.join(', ')
    end

  end
end