require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
    let(:my_user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:post) { create(:post, topic: topic, user: my_user) }
    let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: my_user) }

    context "unauthenticated users" do
        describe "GET index" do
            before { get :index }

            it "returns http success" do
                expect(response).to have_http_status(:success)
            end

            it "returns json content type" do
                expect(response.content_type).to eq("application/json")
            end

            #this test is failing, but calls to the endpoint are successful
            it "returns post serialized" do
                expect(response.body).to eq([comment].to_json)
            end
        end

        describe "GET show" do
            before { get :show, id: comment.id }

            it "returns http success" do
                expect(response).to have_http_status(:success)
            end

            it "returns json content type" do
                expect(response.content_type).to eq "application/json"
            end

            it "returns post serialized" do
                expect(response.body).to eq(comment.to_json)
            end
        end
	end
end