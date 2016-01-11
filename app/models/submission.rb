class Submission < ActiveRecord::Base
  belongs_to :assignment
  validates :author, presence: true
end
