class AddAttachments3ToApplicants < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :attachments3, :string
  end
end
