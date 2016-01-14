require 'test_helper'

class SubmissionsExecuteJobTest < ActiveJob::TestCase
  test 'output is properly given' do
    submission = create :submission, code: 'echo hello world'
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal submission.output, "hello world\n"
  end

  test 'multiple lines work properly' do
    submission = create :submission, code: 'echo hello; echo world'
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal submission.output, "hello\nworld\n"
  end
end
