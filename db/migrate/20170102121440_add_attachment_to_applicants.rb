class AddAttachmentToApplicants < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :attachment, :string
  end
end
