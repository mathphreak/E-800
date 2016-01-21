require 'test_helper'

class SubmissionsExecuteJobTest < ActiveJob::TestCase
  test 'output is properly given' do
    file = create :submitted_file, data: 'echo hello world'
    submission = file.submission
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal submission.output, "hello world\n"
  end

  test 'multiple lines work properly' do
    file = create :submitted_file, data: 'echo hello; echo world'
    submission = file.submission
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal submission.output, "hello\nworld\n"
  end
end
