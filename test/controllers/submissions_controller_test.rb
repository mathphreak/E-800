require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  test 'should create submission' do
    assignment = create :assignment
    assert_difference('assignment.submissions.count') do
      post :create, assignment_id: assignment.id,
                    dont_run: true,
                    submission: { author: 'Test',
                                  code: 'nothing' }
    end

    assert_redirected_to assignment_path(assignment)
  end

  test 'should destroy submission' do
    submission = create :submission
    assignment = submission.assignment
    assert_difference('assignment.submissions.count', -1) do
      delete :destroy, assignment_id: assignment.id,
                       id: submission.id
    end

    assert_redirected_to assignment_path(assignment)
  end
end
