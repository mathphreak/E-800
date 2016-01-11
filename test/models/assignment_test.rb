require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  test 'should save a valid assignment properly' do
    assignment = build(:assignment)
    assert assignment.save
  end

  test 'should not save an assignment with no title' do
    assignment = build(:assignment, :title => nil)
    assert_not assignment.save
  end

  test 'should not save an assignment with no description' do
    assignment = build(:assignment, :description => nil)
    assert_not assignment.save
  end

  test 'should not save an assignment with no run script' do
    assignment = build(:assignment, :run_script => nil)
    assert_not assignment.save
  end
end
