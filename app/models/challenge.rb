class Challenge < ApplicationRecord
  has_many :applicant_result_at_challenges
  has_many :applicants,:through => :applicant_result_at_challenges
end
