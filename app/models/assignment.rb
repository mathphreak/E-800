class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
end
