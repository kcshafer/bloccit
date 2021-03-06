require 'rails_helper'
require 'random_data'

RSpec.describe AdvertisementsController, type: :controller do

let(:advertisement){Advertisement.create!(title: "Test Ad", copy: "I'm an Ad!", price: 50)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns advertisement to @advertisement" do
      get :index
      expect(assigns(:advertisements)).to eq([advertisement])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: advertisement.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, {id: advertisement.id}
      expect(response).to render_template :show
    end

    it "assigns advertisement to @advertisement" do
      get :show, {id: advertisement.id}
      expect(assigns(:advertisement)).to eq(advertisement)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instatiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "GET #create" do
    it "increases the number of advertisements by 1" do
      expect{post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 50.0}}.to change(Advertisement,:count).by(1)
    end

    it "assigns the new advertisement to @advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 50.0}
      expect(assigns(:advertisement)).to eq Advertisement.last
    end

    it "redirects to the new advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: 50.0}
      expect(response).to redirect_to Advertisement.last
    end
  end

end
