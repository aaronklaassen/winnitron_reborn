require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  let(:winnitron) { FactoryGirl.create(:arcade_machine) }
  let(:token) { winnitron.api_keys.first.token }

  describe "GET index" do

    include_examples "disallows bad API keys", :get, :index

    it "accepts API key in params" do
      get :index, { api_key: token, format: "json" }
      expect(response).to have_http_status(:ok)
    end

    it "accepts API key in headers" do
      request.headers["Authorization"] = "Token #{token}"
      get :index, { format: "json" }
      expect(response).to have_http_status(:ok)
    end

    it "assigns the machine's games" do
      all = FactoryGirl.create_list(:game, 3)
      all.last(2).each { |g| Installation.create! game: g, arcade_machine: winnitron }
      
      request.headers["Authorization"] = "Token #{token}"
      get :index, { format: "json" }
      expect(assigns(:games)).to eq all.last(2)
    end

  end

end