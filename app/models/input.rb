class Input < ActiveRecord::Base
  belongs_to :team
  belongs_to :answer

  scope :recent_input_by_team_and_answer, ->(team_id, answer_id) do
    where(team_id: team_id).where(answer_id: answer_id).order('created_at DESC').limit(1)
  end
end
