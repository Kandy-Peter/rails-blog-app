require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    @user = User.new(name: 'Kandy', photo: 'https://microverse_student.com/img1', bio: 'software Developer form Congo')
    Post.new(author: @user, title: 'post test', text: 'content for checking tests', comments_counter: 0, likes_counter: 0)
  end
  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title content max 250 characters' do
    subject.title = "title"
    expect(subject).to be_valid
  end

  it 'test if likes counter is greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'test if likes counter is integer' do
    subject.likes_counter = 3
    expect(subject).to be_valid
  end
end
