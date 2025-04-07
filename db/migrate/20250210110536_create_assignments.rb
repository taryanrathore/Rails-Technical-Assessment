class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.string :title, null: false
      t.text :description
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
