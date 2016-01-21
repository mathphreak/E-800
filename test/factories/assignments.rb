FactoryGirl.define do
  factory :assignment do
    title 'Hello World'
    description 'Write a shell script that prints \"hello world\"'
    run_script '#!/bin/bash
    sh code.txt
    '
  end
end
