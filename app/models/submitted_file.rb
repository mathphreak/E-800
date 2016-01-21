class SubmittedFile < ActiveRecord::Base
  belongs_to :file_spec
  belongs_to :submission, autosave: true, touch: true
end
