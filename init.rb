#!/usr/bin/ruby

require_relative "computer.rb"
require_relative "ds.rb"

computer = Computer.new(1, DS.new)

puts computer.keyboard 
puts computer.mouse 
puts computer.cpu 
puts computer.display 