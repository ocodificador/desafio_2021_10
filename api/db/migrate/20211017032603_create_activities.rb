class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :project, foreign_key: true,  null: false
      t.string :name,                            null: false
      t.date :start_date,                        null: false
      t.date :end_date,                          null: false
      t.boolean :finished, default: false,       null: false

      t.timestamps
    end
  end
end
