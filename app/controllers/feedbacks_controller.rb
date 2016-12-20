class FeedbacksController < ApplicationController
  def create
    feedback = Feedback.new(feedback_params)
    feedback.ip = request.remote_ip
    feedback.save
    redirect_back fallback_location: page_path(page: "pricing"), flash: {success: "We got your feedback. Thank you!"}
  end

  private

  def feedback_params
    params.require(:feedback).permit({answers: [:apps, :sync, :editor]}, :comment)
  end
end
