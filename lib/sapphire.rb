require 'sapphire/version'
require 'sapphire/abstract'
require 'sapphire/compiler'
require 'sapphire/parserstate'

module Sapphire
  def self.escape_str(str)
    str.gsub('\\', '\\\\').gsub("'", "\\'")
  end

  def self.prepare_args(indent, options, state, args)
    "(#{args.map {|el| el.to_lua(indent + 1, options, state)}.join ', '})"
  end
end