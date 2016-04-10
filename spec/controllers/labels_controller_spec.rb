require 'rails_helper'

RSpec.describe LabelsController, type: :controller do
	let(:label) { create(:label, name: "L1") }

  	describe "GET #show" do
    	it "returns http success" do
      		get :show, {id: label.id}
      		expect(response).to have_http_status(:success)
    	end

    	it "renders the #show view" do
    		get :show, { id: label.id }
    		expect(response).to render_template :show
    	end

    	it "assigns label to @label" do
    		get :show, { id: label.id }
    		expect(assigns(:label)).to eq(label)
    	end
  	end
end
