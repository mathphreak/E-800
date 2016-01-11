class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :description, presence: true,
                          length: { minimum: 10 }
  validates :run_script, presence: true
end
