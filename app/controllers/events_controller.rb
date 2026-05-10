class EventsController < ApplicationController
  def index
    @events = Event.includes(:event_vote_counter).order(start_at: :desc).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def upvote
    event = Event.find(params[:id])
    event.increment!(:vote_count)

    redirect_to events_path(page: params[:page]), notice: "Vote added."
  end

  def downvote
    event = Event.find(params[:id])
    event.decrement!(:vote_count) if event.vote_count.positive?

    redirect_to events_path(page: params[:page]), notice: "Vote removed."
  end
end
