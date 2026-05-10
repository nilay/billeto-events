class FetchBillettoEventsJob < ApplicationJob
  queue_as :default

  def perform
    Billetto::EventFetcher.new.call
  end
end
