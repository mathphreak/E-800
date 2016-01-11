require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  test 'should save a valid submission properly' do
    submission = build(:submission)
    assert submission.save
  end

  test 'should not save a submission with no author' do
    submission = build(:submission, :author => nil)
    assert_not submission.save
  end
end
