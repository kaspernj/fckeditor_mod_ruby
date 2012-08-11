#!/usr/bin/ruby

require "rubygems"
require "php4r"

knjrbfw_path = nil
tmp_path = nil
ARGV.each do |val|
  if match = val.match(/--tmp_path=(.+)/)
    tmp_path = match[1]
  else
    raise "Invalid argument: '#{val}'."
  end
end

raise "No tmp-path was given.\n" if !tmp_path

$validate_login = Php4r.json_decode(Php4r.base64_decode(File.read(tmp_path)))
require $validate_login["args"]["script"]
