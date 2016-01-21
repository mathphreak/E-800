require 'test_helper'

class SubmittedFileTest < ActiveSupport::TestCase
  test 'should save a valid submitted file properly' do
    file = build :submitted_file
    assert file.save
  end
end
