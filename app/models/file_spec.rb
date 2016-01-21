class FileSpec < ActiveRecord::Base
  belongs_to :assignment, autosave: true, touch: true

  validates :name, presence: true
end
