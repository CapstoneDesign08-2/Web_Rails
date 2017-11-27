class Applicant < ApplicationRecord
  has_secure_token :token
  has_many :applicnat_result_at_challenges
  has_many :challenges,:through => :applicant_result_at_challenges
end
