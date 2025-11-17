#!/usr/bin/env ruby
require "yaml"
require "fileutils"

data = YAML.load_file("_data/cards.yml")
cards = data["cards"]

FileUtils.mkdir_p("cards")

cards.each do |entry|
  file, meta = entry.first

  html = <<~HTML
  ---
  layout: card
  title: "#{meta['title']}"
  file: "#{file}"
  suit: "#{meta['suit']}"
  group: "#{meta['group']}"
  rarity: "#{meta['rarity']}"
  description: "#{meta['description']}"
  ---
  HTML

  File.write("cards/#{file.sub('.webp', '.html')}", html)
end
