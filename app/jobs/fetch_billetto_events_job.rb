class FetchBillettoEventsJob < ApplicationJob
  queue_as :default

  def perform
    Billetto::EventHandler.new(
      Billetto::Client.new(Rails.application.credentials[:billetto_api_keypair])
    ).call
  end
end
