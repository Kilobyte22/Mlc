#!/usr/bin/env ruby
require 'optparse'

libs = []
OptionParser.new do |opts|
  opts.banner = 'Usage: mlc [flags] input... output'
  opts.on('-l', '--library NAME', 'Include lib in output') do |v|
    libs << v
  end
end.parse!

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../lib'))) if defined? $DEBUG && $DEBUG

require 'mlc'

if ARGV.length < 2
  $stderr.puts 'Usage: input... output'
  $stderr.puts 'Example: hello.rb world.rb out.lua'
  exit 1
end

out = ARGV.pop
outdata = []

libs.each do |lib|
  outdata << Mlc::Builder.build(lib)
end

ARGV.each do |file|
  outdata << Mlc::Compiler.new(File.read(file)).parse!.to_lua
end

File.write(out, outdata.join("\n"))