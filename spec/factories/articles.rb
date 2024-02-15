FactoryBot.define do
  factory :article do
    title { 'Sample Title' }
    body { 'Sample Body' }
    association :author
    published { true }
    free { true }
  end
end
