require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user) { FactoryBot.build(:user) }
  let(:invalid_user) { FactoryBot.build(:user, password: 'qweqweqwe') }

  it { is_expected.to have_many :projects }

  context 'Validate User password' do
    it 'does not save User with invalid password' do
      expect(invalid_user).not_to be_valid
      invalid_user.valid?
    end

    it 'saves User with valid password' do
      expect(valid_user).to be_valid
      valid_user.valid?
    end
  end
end
