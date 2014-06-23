#!/usr/bin/env ruby
require 'optparse'

nogem = false
OptionParser.new do |opts|
  opts.banner = 'Usage: mlc [flags] input... output'
  opts.on('-g', '-nogem', 'Do not run as gem') do |v|
    nogem = true
  end
end#.parse!

$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '../lib'))) if defined? $DEBUG && $DEBUG

require 'mlc'

if ARGV.length < 2
  $stderr.puts 'Usage: input... output'
  $stderr.puts 'Example: hello.rb world.rb out.lua'
  exit 1
end

out = ARGV.pop
outdata = []
ARGV.each do |file|
  outdata << Mlc::Compiler.new(File.read(ARGV[0])).parse!.to_lua
end

File.write(out, outdata.join("\n"))