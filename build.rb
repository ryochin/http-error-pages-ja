#!/usr/bin/env ruby

require 'yaml'
require 'erb'

# pages
YAML.load_file('./http_status_code.yml').each do |group|
  group['list'].each do |data|
    file = "#{data['code']}.html"

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
content << '</ul></body></html>'
File.write 'index.html', content.join("\n") + "\n"
