require 'rails_helper'

RSpec.describe User::Create do
  context 'success' do
    subject { described_class.call }

    it 'is authenticate and creates token' do
      expect { subject }.to change(User, :count).from(0).to(1)
      expect(subject).to be_success
    end
  end
end
