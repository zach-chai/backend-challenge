require 'open-uri'

class WebScraper
  def initialize(website)
    @website = website
  end

  def scrape
    doc = Nokogiri::HTML.parse(URI.open(@website))
    return doc.css('h1,h2,h3').map(&:text)
  end
end
