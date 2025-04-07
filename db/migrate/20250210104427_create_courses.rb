class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.string :status, null: false
      t.references :term, null: false, foreign_key: true
      t.timestamps
    end
    add_index :courses, :code, unique: true
  end
end
