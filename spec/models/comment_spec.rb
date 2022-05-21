require 'rails_helper'

RSpec.describe Comment, type: :model do

  before(:each) do
    @comment = Comment.new(text: 'Good Job!', author_id: 9, post_id: 12)
  end

  before { @comment.save }

  it "text shouldn't be empty" do
    @comment.text = nil
    expect(@comment).to_not be_valid
  end

  it 'if post_id is not present' do
    @comment.post_id = nil
    expect(@comment).to_not be_valid
  end

  it "author_id shouldn't be a string" do
    @comment.author_id = 'string'
    expect(@comment).to_not be_valid
  end
end
