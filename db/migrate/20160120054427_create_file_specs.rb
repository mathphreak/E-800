class CreateFileSpecs < ActiveRecord::Migration
  def change
    create_table :file_specs do |t|
      t.string :name
      t.references :assignment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
