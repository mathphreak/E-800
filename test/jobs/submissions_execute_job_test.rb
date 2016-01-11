require 'test_helper'

class SubmissionsExecuteJobTest < ActiveJob::TestCase
  test "output is properly given" do
    submissions = create :submission
    SubmissionsExecuteJob.perform_now(submissions)
    assert_not submissions.pending
  end
end
