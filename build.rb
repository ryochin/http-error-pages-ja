#!/usr/bin/env ruby

require 'yaml'
require 'erb'

subtitle_maker = lambda { |data|
  data.slice('code', 'text').values.map(&:to_s).reject(&:empty?).join(' ')
}

# http error pages
YAML.load_file('./http_status_code.yml').each do |group|
  group['list'].each do |data|
    file = "#{data['code']}.html"

    subtitle = subtitle_maker.call(data)

    erb = ERB.new(File.read('./template.html'))
    File.write file, erb.result(binding).gsub(/\n+/o, "\n")
  end
end

# extra pages
YAML.load_file('./extra.yml').each do |group|
  group['list'].each do |data|
    file = "#{data['file']}.html"

    subtitle = subtitle_maker.call(data)

    erb = ERB.new(File.read('./template.html'))
    File.write file, erb.result(binding).gsub(/\n+/o, "\n")
  end
end

# index
content = []
content << '<!DOCTYPE html><html><head><title>index</title></head><body><ul>'
content += YAML.load_file('./http_status_code.yml').reduce([]) { |a, e| a + e['list'] }.map { |data|
  '<li>%d: <a href="%d.html">%s</a></li>' % [data['code'], data['code'], data['text']]
}
content += YAML.load_file('./extra.yml').reduce([]) { |a, e| a + e['list'] }.map { |data|
  '<li><a href="%s.html">%s</a></li>' % [data['file'], data['text']]
}
content << '</ul></body></html>'
File.write 'index.html', content.join("\n") + "\n"
