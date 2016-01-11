class SubmissionsExecuteJob < ActiveJob::Base
  queue_as :default

  def perform(submission)
    submission.output = "RUN INTERNALLY"
    submission.pending = false
    submission.save
  end
end
