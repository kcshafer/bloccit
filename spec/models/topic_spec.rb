require 'rails_helper'
require 'random_data'
require 'shoulda'

RSpec.describe Topic, type: :model do
    let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

    it { is_expected.to have_many(:posts)}
    it { is_expected.to have_many(:labelings) }
    it { is_expected.to have_many(:labels).through(:labelings) }

    describe "attributes" do
        it "responds to name and description attributes" do
            expect(topic).to have_attributes(name: topic.name, description: topic.description)
        end

        it "responds to public" do
            expect(topic).to respond_to(:public)
        end

        it "is public by default" do
            expect(topic.public).to be(true)
        end
    end
end
