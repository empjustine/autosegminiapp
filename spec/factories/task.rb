FactoryBot.define do
  sequence :description do |n|
  "task ##{n}"
  end
end

FactoryBot.define do
  factory :task, :class => 'Task' do
    description
  end
end