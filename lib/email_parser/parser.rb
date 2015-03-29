module EmailParser
  class Parser
    attr_accessor :url_params
      def initialize url_params
        @url = url_params
      end

    def parsing
      binding.pry
    end
  end
end
