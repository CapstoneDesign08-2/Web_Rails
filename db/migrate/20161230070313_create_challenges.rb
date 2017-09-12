class CreateChallenges < ActiveRecord::Migration[5.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :goal
      t.text :information
      t.string :description

      t.timestamps
    end
  end
end
