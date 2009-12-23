#!/usr/bin/env ruby

#Figure out where to find the replacement files
replacementsDir = File.expand_path __FILE__
if File.symlink? replacementsDir
    replacementsDir = File.readlink replacementsDir
end
$replacementsDir = File.dirname(replacementsDir) + '/replacements'

#########

$symbols = Hash.new

def replacement(text)
    text #DUMMY
end

#########

$stdin.each do |line|
    line.gsub! /\{(.+?)\}/ do
        replacement $1
    end
    puts line
end
