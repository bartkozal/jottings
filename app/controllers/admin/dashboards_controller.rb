class Admin::DashboardsController < AdminController
  def show
    @feedback_comments = Feedback.where.not(comment: "").order(created_at: :desc)
    @feedback_answers = Feedback.all.map(&:answers).inject do |mem, hash|
      mem.merge(hash) do |_, old_value, new_value|
        old_value.to_i + new_value.to_i
      end
    end
  end
end
