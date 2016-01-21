class Submission < ActiveRecord::Base
  belongs_to :assignment

  has_many :submitted_files, dependent: :destroy
  accepts_nested_attributes_for :submitted_files, allow_destroy: true,
                                                  reject_if: :all_blank
  after_initialize :ensure_submitted_files

  validates :author, presence: true

  protected

  def ensure_submitted_files
    return unless submitted_files.empty?
    return unless assignment
    assignment.file_specs.each do |file_spec|
      submitted_files.build file_spec_id: file_spec.id
    end
  end
end
