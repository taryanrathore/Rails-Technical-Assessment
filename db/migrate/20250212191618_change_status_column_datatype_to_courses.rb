class ChangeStatusColumnDatatypeToCourses < ActiveRecord::Migration[8.0]
  def up
  change_column :courses, :status, 'integer USING status::integer'
  change_column_default :courses, :status, 0
  end

  def down
    change_column :courses, :status, :string
    change_column_default :courses, :status, 0
  end
end
