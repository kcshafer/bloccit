require 'rails_helper'

RSpec.describe Post, type: :model do
    let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
    let(:post) { Post.create!(title: "New Post Title", body: "New Post Body") }

    it { is_expected.to belong_to(:topic) }

    describe "attributes" do
        it "responds to title" do
            expect(post).to respond_to(:title)
        end

        it "responds to body" do
            expect(post).to respond_to(:body)
        end
    end
end
