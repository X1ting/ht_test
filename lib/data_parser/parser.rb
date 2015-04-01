require 'open-uri'
require 'rubygems'
require 'nokogiri'

module DataParser
  class Parser
      def initialize url
        @url = url[:url]
      end

    def parsing
      start_time = Time.now
      hrefs = get_all_hrefs
      temp_links = hrefs
      @temp = []
      tmp_url = @url
      #binding.pry
      temp_links.each do |temp|
        puts temp
        u = temp[0] == '/' ? temp.prepend(@url) : temp
        # if temp[0] == '/'
        #   u = temp.prepend(@url)
        # else
        #   u = temp
        # end
        doc = Nokogiri::HTML(open(u)) rescue next
        links = doc.css('a')
        temp_hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if{|href| href.empty?}
        @temp.push(temp_hrefs)
      end
      #binding.pry
      tmp = @temp.flatten.uniq
      tmp.map! do |t|
        if t[0] == '/' || t[0] == '?'
          t.prepend(@url+'/')
        else
          t
        end
      end

      #binding.pry
      addresses = []
      hrefs = temp_links + tmp
      hrefs.uniq.each do |link|
        doc = Nokogiri::HTML(open(link)) rescue next
        email_address = doc.to_s.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)
        addresses.push(email_address.to_s)
      end
      #binding.pry
      end_time = Time.now - start_time
      addresses.push("Time: " + end_time.to_s)
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
