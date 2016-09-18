require 'test_helper'

class SubmissionsExecuteJobTest < ActiveJob::TestCase
  test 'output is properly given' do
    file = create :submitted_file, data: 'echo hello world'
    submission = file.submission
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal "hello world\n", submission.output
  end

  test 'multiple lines work properly' do
    file = create :submitted_file, data: 'echo hello; echo world'
    submission = file.submission
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal "hello\nworld\n", submission.output
  end

  test 'multiple files work properly' do
    assignment = create(:assignment, run_script: 'sh display.sh')
    message = assignment.file_specs.create name: 'message.txt'
    display = assignment.file_specs.create name: 'display.sh'
    submission = create(:submission, assignment: assignment)
    assert_equal 'sh display.sh', submission.assignment.run_script
    submission.submitted_files.create file_spec_id: message.id,
                                      data: 'hello world'
    submission.submitted_files.create file_spec_id: display.id,
                                      data: 'cat message.txt'
    SubmissionsExecuteJob.perform_now(submission)
    assert_not submission.pending
    assert_equal "hello world\n", submission.output
  end
end
