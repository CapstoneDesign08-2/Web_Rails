class AddStringlogToApplicants < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :log, :text
  end
end
