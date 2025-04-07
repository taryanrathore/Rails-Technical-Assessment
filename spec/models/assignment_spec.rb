require 'rails_helper'

RSpec.describe Assignment, type: :model do
  subject { build(:assignment) }

  describe 'associations' do
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a title' do
      subject.title = nil
      expect(subject).to be_invalid
      expect(subject.errors[:title]).to include("can't be blank")
    end
  end
end
