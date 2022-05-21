require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'check likes model' do
    before(:each) do
      @like = Like.new(author_id: 6, post_id: 1)
    end

    before { @like.save }

    it "author_id shouldn't be a string" do
      subject.author_id = 'string'
      expect(subject).to_not be_valid
    end

    it 'if post_id is present' do
      @like.post_id = nil
      @like.author_id = nil
      expect(@like).to_not be_valid
    end
  end
end
