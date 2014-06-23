require 'ruby_parser'
require 'mlc/abstract/snippet'
require 'mlc/abstract/call'
require 'mlc/abstract/raw'
require 'mlc/abstract/block'
require 'mlc/abstract/literal'
require 'mlc/abstract/const'
require 'mlc/abstract/lasgn'
require 'mlc/abstract/lvar'

module Mlc
  class Compiler
    def initialize(code)
      @tree = RubyParser.new.parse(code)
    end

    def parse!
      puts (tree = @tree).inspect
      snip = Mlc::Abstract::Snippet.new
      if tree
        snip << ensure_block(tree)
      end
      snip
    end

    def ensure_block(sexp)
      unless sexp[0] == :block
        sexp = Sexp.new :block, sexp
      end
      parse_block(sexp)
    end

    def parse(sexp)
      if sexp.nil?
        nil
      else
        send(('parse_' + sexp[0].to_s).to_sym, sexp)
      end
    end

    def parse_block(sexp)
      block = Abstract::Block.new
      sexp[1..sexp.length].each do |el|
        block << parse(el)
      end
      block
    end

    def parse_call(sexp)
      call = Abstract::Call.new
      call.object = parse(sexp[1]) || Abstract::Raw.new('self')
      call.name = sexp[2]
      sexp[3..sexp.length].each do |arg|
        call.args << parse(arg)
      end
      call
    end

    def parse_str(sexp)
      Abstract::Literal.new(sexp[1])
    end

    def parse_lit(sexp)
      Abstract::Literal.new(sexp[1])
    end

    def parse_const(sexp)
      Abstract::Const.new(sexp[1].to_s)
    end

    def parse_lasgn(sexp)
      Abstract::LAsgn.new(sexp[1], parse(sexp[2]))
    end

    def parse_lvar(sexp)
      Abstract::LVar.new(sexp[1])
    end

  end
end