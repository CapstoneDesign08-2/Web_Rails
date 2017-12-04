class CreateApplicantResultAtChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :applicant_result_at_challenges do |t|
      t.belongs_to :challenges, index:true
      t.belongs_to :applicants, index:true
      t.integer :score
      t.string :attachment
      t.text :log
      t.string :language

      t.timestamps
    end
  end
end
