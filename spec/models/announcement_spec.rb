require 'rails_helper'

RSpec.describe Announcement, type: :model do
  subject { build(:announcement) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is invalid without a title' do
      subject.title = nil
      expect(subject).to be_invalid
      expect(subject.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without content' do
      subject.content = nil
      expect(subject).to be_invalid
      expect(subject.errors[:content]).to include("can't be blank")
    end
  end

  describe 'attachments' do
    it 'can have an image attached' do
      image_data = StringIO.new("\x89PNG\r\n\x1A\n".b)
      subject.image.attach(
        io: image_data,
        filename: 'test.png',
        content_type: 'image/png'
      )
  
      expect(subject.image).to be_attached
    end
  end
end
