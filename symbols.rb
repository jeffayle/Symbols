#!/usr/bin/env ruby

#Figure out where to find the replacement files
replacementsDir = File.expand_path __FILE__
if File.symlink? replacementsDir
    replacementsDir = File.readlink replacementsDir
end
$replacementsDir = File.dirname(replacementsDir) + '/replacements/'
$replacementsDir = File.expand_path($replacementsDir,
        File.dirname(__FILE__)) + '/'

#########

$symbols = Hash.new

def loadType(type)
    $symbols[type] = Hash.new
    File.read($replacementsDir+type).split("\n").each do |l|
        name, sym = l.split ':'
        $symbols[type][name] = sym
    end
end

def replacement(text)
    type, symbol = text.split '/', 2
    unless $symbols[type]
        loadType type
    end

    if $symbols[type] and $symbols[type][symbol]
        $symbols[type][symbol]
    else
        "{* Symbol not found: #{symbol}}"
    end
end

#########

$stdin.each do |line|
    line.gsub! /\{(.+?)\}/ do
        replacement $1
    end
    puts line
end
