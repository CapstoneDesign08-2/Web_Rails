class RemoveAttributesToApplicants < ActiveRecord::Migration[5.0]
  def change
    remove_column :applicants, :attachment, :string
    remove_column :applicants, :attachments3, :string
    remove_column :applicants, :log, :text
  end
end
