RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_many(:videos) }
end
