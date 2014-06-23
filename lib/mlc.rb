require 'mlc/version'
require 'mlc/abstract'
require 'mlc/compiler'
require 'mlc/parserstate'
require 'mlc/builder'

module Mlc

  @@root = File.expand_path(File.join(File.dirname(__FILE__), '../'))
  def self.root(dir = nil)
    dir ? File.join(@@root, dir) : @@root
  end

  def self.escape_str(str)
    str.gsub('\\', '\\\\').gsub("'", "\\'")
  end

  def self.prepare_args(indent, options, state, args)
    "(#{args.map {|el| el.to_lua(indent + 1, options, state)}.join ', '})"
  end
end