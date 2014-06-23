require 'mlc/version'
require 'mlc/abstract'
require 'mlc/compiler'
require 'mlc/parserstate'

module Mlc
  def self.escape_str(str)
    str.gsub('\\', '\\\\').gsub("'", "\\'")
  end

  def self.prepare_args(indent, options, state, args)
    "(#{args.map {|el| el.to_lua(indent + 1, options, state)}.join ', '})"
  end
end