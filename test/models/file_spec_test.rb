require 'test_helper'

class FileSpecTest < ActiveSupport::TestCase
  test 'should save a file spec properly' do
    file_spec = build(:file_spec)
    assert file_spec.save
  end

  test 'should not save a file spec with no name' do
    file_spec = build(:file_spec, name: '')
    assert_not file_spec.save
  end
end
