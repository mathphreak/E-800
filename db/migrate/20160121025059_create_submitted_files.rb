class CreateSubmittedFiles < ActiveRecord::Migration
  def change
    create_table :submitted_files do |t|
      t.binary :data
      t.references :file_spec, index: true, foreign_key: true
      t.references :submission, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
