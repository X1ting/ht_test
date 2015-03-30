require 'open-uri'
require 'rubygems'
require 'nokogiri'

module DataParser
  class Parser
    attr_accessor :url_params
      def initialize url_params
        @url = url_params
      end

    def parsing
      hrefs = get_all_hrefs
      addresses = []
      hrefs.each do |link|
        link.prepend(@url)
        selector = "//a[starts-with(@href, \"mailto:\")]/@href"
        doc = Nokogiri::HTML(open(link)) rescue next
        email_address = doc.to_s.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)
        puts email_address
        addresses.push(email_address.to_s)
      end
      addresses.uniq
    end

    def get_all_hrefs
      doc = Nokogiri::HTML(open(@url))
      links = doc.css('a')
      hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if{|href| href.empty?}
      hrefs.push(@url)
    end
  end
end
