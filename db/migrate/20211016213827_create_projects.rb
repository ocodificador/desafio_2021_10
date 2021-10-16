class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name,       null: false
      t.date :start_date,   null: false
      t.date :end_date,     null: false

      t.timestamps
    end
  end
end
