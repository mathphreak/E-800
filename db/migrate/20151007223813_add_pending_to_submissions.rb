class AddPendingToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :pending, :boolean
  end
end
