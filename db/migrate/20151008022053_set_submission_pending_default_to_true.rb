class SetSubmissionPendingDefaultToTrue < ActiveRecord::Migration
  def change
    change_column_default :submissions, :pending, true
  end
end
