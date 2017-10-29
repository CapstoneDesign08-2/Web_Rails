class RemoveDetailsToApplicants < ActiveRecord::Migration[5.0]
  def change
    remove_column :applicants, :score, :integer
    remove_column :applicants, :language, :string
    remove_column :applicants, :challenge_id, :integer
  end
end
