#!/usr/bin/ruby

require "rubygems"
require "knj/autoload"

knjrbfw_path = nil
tmp_path = nil
ARGV.each do |val|
  if match = val.match(/--tmp_path=(.+)/)
    tmp_path = match[1]
  elsif match = val.match(/--knjrbfw_path=(.+)/)
    knjrbfw_path = match[1]
  end
end

if knjrbfw_path
  require "#{knjrbfw_path}/knjrbfw.rb"
else
  require "knjrbfw"
end

if !tmp_path
  print "No tmp-path was given.\n"
  exit
end

$validate_login = Knj::Php.json_decode(Knj::Php.base64_decode(File.read(tmp_path)))
require $validate_login["args"]["script"]
