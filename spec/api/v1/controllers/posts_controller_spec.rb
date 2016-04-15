require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
    let(:my_user) { create(:user) }
    let(:post) { create(:post) }

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
                expect(response.body).to eq([post].to_json)
            end
        end

        describe "GET show" do
            before { get :show, id: post.id }

            it "returns http success" do
                expect(response).to have_http_status(:success)
            end

            it "returns json content type" do
                expect(response.content_type).to eq "application/json"
            end

            it "returns post serialized" do
                expect(response.body).to eq(post.to_json)
            end
        end
    end
end