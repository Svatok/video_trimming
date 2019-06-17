RSpec.describe Video, type: :model do
  it { is_expected.to be_mongoid_document }

  it { is_expected.to have_field(:name).of_type(String) }
  it { is_expected.to have_field(:source_video_data).of_type(String) }

  it { is_expected.to belong_to(:user) }
end
