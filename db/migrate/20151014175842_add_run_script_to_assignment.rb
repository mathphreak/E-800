class AddRunScriptToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :run_script, :text
  end
end
