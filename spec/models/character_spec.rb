require 'rails_helper'

RSpec.describe Character, type: :model do
  subject do
    create(:character)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a campaign' do
    subject.campaign = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a pc_class' do
    subject.pc_class = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a level' do
    subject.level = nil
    expect(subject).to_not be_valid
  end

  it 'can own a blue book' do
    create(:blue_book, character: subject)
    expect(subject.blue_books.count).to eq(1)
  end
end
