require 'rails_helper'

RSpec.describe Term, type: :model do
  describe 'associations' do
    it { should have_many(:courses).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      term = build(:term)
      expect(term).to be_valid
    end

    it 'is not valid without a name' do
      term = build(:term, name: nil)
      expect(term).not_to be_valid
      expect(term.errors[:name]).to include("can't be blank")
    end
  end

  describe 'database schema' do
    it 'has a name column of type string' do
      column = Term.columns_hash['name']
      expect(column.type).to eq(:string)
      expect(column.null).to be false
    end
  end
end
