class EventsController < ApplicationController
  def index
    @events = Event.order(start_at: :desc).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
