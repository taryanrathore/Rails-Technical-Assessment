# spec/models/course_spec.rb
require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { should belong_to(:term) }
    it { should have_many(:assignments).dependent(:destroy) }
  end

  describe 'validations' do
    it 'validates uniqueness of code' do
      existing = create(:course, code: 'IT-999-OLA1')
      duplicate = build(:course, code: 'IT-999-OLA1')
      expect(duplicate).not_to be_valid
    end
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(active: 0, closed: 1) }
  end

  describe 'callbacks' do
    it 'generates a course code before creation' do
      course = create(:course)
      expect(course.code).to match(/^IT-\d{3}-OLA[1-5]$/)
    end
  end

  describe 'database indexes' do
    it 'has a unique index on code' do
      index = ActiveRecord::Base.connection.indexes(:courses).find { |i| i.columns == ['code'] }
      expect(index.unique).to be true
    end
  end
end
