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
  ---

  <div class="card-page">
    <img class="card-image" src="{{ site.baseurl }}/assets/cards/#{file }}" alt="#{meta['description']}">
    <div class="card-info">
      <p><strong>Suit:</strong> #{data["suits"][meta["suit"]]}</p>
      <p><strong>Group:</strong> #{data["groups"][meta["group"]]}</p>
      <p><strong>Rarity:</strong> #{data["rarity"][meta["rarity"]]}</p>
      <p><strong>Description:</strong> #{meta['description']}</p>
    </div>
  </div>
  HTML

  File.write("cards/#{file.sub('.webp', '.html')}", html)
end
