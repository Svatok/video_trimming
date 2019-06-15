FactoryBot.define do
  factory :video do
    name { FFaker::Name.name }

    trait :with_source_file do
      favicon { File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_video.mp4')) }
    end
  end
end
