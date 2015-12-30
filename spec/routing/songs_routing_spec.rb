require "rails_helper"

RSpec.describe SongsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/records/1/songs/new").to route_to("songs#new", record_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/records/1/songs/1").to route_to("songs#show", id: "1", record_id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/records/1/songs/1/edit").to route_to("songs#edit", id: "1", record_id: "1")
    end

    it "routes to #create" do
      expect(:post => "/records/1/songs").to route_to("songs#create", record_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/records/1/songs/1").to route_to("songs#update", id: "1", record_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/records/1/songs/1").to route_to("songs#update", id: "1", record_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/records/1/songs/1").to route_to("songs#destroy", id: "1", record_id: "1")
    end

  end
end
