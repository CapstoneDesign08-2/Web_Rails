class ApplicantResultAtChallenge < ApplicationRecord
  belongs_to :applicant
  belongs_to :challenge
  mount_uploader :attachment, AttachmentUploader
end
