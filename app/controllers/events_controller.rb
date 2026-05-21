class EventsController < ApplicationController
  before_action :require_clerk_login_for_voting, only: %i[upvote downvote]

  def index
    @events = Event.includes(:event_vote_counter).order(start_at: :desc).page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def upvote
    redirect_after_vote(
      Rails.application.config.command_bus.dispatch(
        UpvoteCommand.new(
          event_id: params[:id],
          clerk_user_id: current_clerk_user.id,
          ip: request.remote_ip
        )
      )
    )
    
  end

  def downvote
    redirect_after_vote(
      Rails.application.config.command_bus.dispatch(
        DownvoteCommand.new(
          event_id: params[:id],
          clerk_user_id: current_clerk_user.id,
          ip: request.remote_ip
        )
      )
    )
  end

  private

  def require_clerk_login_for_voting
    return if clerk_signed_in?

    redirect_to events_path(page: params[:page]), alert: "Sign in with Clerk to vote on events."
  end

  def redirect_after_vote(changed)
    notice =
      if changed
        "Your vote has been logged."
      else
        "That vote is already recorded for this event."
      end

    redirect_to events_path(page: params[:page], anchor: "event_#{params[:id]}"),
      notice: notice,
      status: :see_other
  end
end
