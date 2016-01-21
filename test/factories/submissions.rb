FactoryGirl.define do
  factory :submission do
    author 'Matt Horn'
    code '#!/bin/bash
    echo "hello world"
    '
    assignment
  end
end
