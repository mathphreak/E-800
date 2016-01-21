class Assignment < ActiveRecord::Base
  has_many :submissions, dependent: :destroy

  has_many :file_specs, dependent: :destroy
  accepts_nested_attributes_for :file_specs, allow_destroy: true,
                                             reject_if: :all_blank
  validates_associated :file_specs

  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :description, presence: true,
                          length: { minimum: 10 }
  validates :run_script, presence: true
end
