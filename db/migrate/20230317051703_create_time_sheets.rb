class CreateTimeSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :time_sheets do |t|
      t.datetime :time
      t.boolean :type
      t.date :date
      t.references :user, null: false, foreign_key: true

    
      t.timestamps
    end
  end
end
