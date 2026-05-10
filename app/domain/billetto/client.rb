require "httparty"
module Billetto
  class Client
    BASE_URL = "https://billetto.dk".freeze
    LIMIT = 100

    def initialize(api_keypair)
      @options = { headers: {
        "Api-Keypair" => api_keypair,
        "Content-Type" => "application/json"
        }
      }
    end

    def api_url
      "#{BASE_URL}/api/v3/public/events?limit=#{LIMIT}"
    end

    def fetch_events(url = api_url, &block)
      response = nil
      RetryErrors.new(Net::OpenTimeout, Net::ReadTimeout).try(times: 3) do
        response = HTTParty.get(url, @options)
      end

      parsed_data = response.parsed_response
      yield parsed_data["data"]

      fetch_events(parsed_data["next_url"], &block) if parsed_data["has_more"]
    end
  end
end
