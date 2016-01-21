FactoryGirl.define do
  factory :assignment do
    title 'Hello World'
    description 'Submit whatever and this prints \"hello world\"'
    run_script '#!/bin/bash
    sh code.txt
    '
  end
end
