require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      favorite = build(:favorite)
      expect(favorite).to be_valid
    end

    it 'is not valid without a user' do
      favorite = build(:favorite, user: nil)
      expect(favorite).not_to be_valid
      expect(favorite.errors[:user]).to include("must exist")
    end

    it 'is not valid without a course' do
      favorite = build(:favorite, course: nil)
      expect(favorite).not_to be_valid
      expect(favorite.errors[:course]).to include("must exist")
    end
  end

  describe 'database indexes' do
    it 'has an index on user_id' do
      indexes = ActiveRecord::Base.connection.indexes(:favorites)
      user_index = indexes.find { |i| i.columns == ['user_id'] }
      expect(user_index).not_to be_nil
    end

    it 'has an index on course_id' do
      indexes = ActiveRecord::Base.connection.indexes(:favorites)
      course_index = indexes.find { |i| i.columns == ['course_id'] }
      expect(course_index).not_to be_nil
    end
  end
end
