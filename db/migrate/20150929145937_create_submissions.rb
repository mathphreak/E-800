class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :author
      t.text :code
      t.references :assignment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
