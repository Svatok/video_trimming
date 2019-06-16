FactoryBot.define do
  factory :video do
    name { FFaker::Name.name }

    trait :with_source_video do
      source_video { File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_video.mp4')) }
    end
  end
end
