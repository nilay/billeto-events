module Billetto
  class EventHandler
    def initialize(client)
      @client = client
    end

    def call
      @client.fetch_events { |events| upsert_events(events) }
    end

    private

    def upsert_events(data)
      event_attributes = data.map do |event_data|
        {
          external_id: event_data["id"],
          name: event_data["title"],
          start_at: safe_parse_date(event_data["startdate"]),
          description: event_data["description"],
          image_url: event_data["image_link"]
        }
      end
      Event.upsert_all(
        event_attributes,
        unique_by: :external_id,
        record_timestamps: true
      )
    end
    private

    def safe_parse_date(date_string)
      return nil if date_string.blank?
      Time.parse(date_string)
    rescue ArgumentError, TypeError
      nil
    end
  end
end
