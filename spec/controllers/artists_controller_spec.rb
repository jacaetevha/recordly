require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do

  let(:user) { new_user }

  # This should return the minimal set of attributes required to create a valid
  # Artist. As you add validations to Artist, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    name: 'valid attribute'
  }}

  let(:invalid_attributes) {{
    name_it_isnt: 'invalid attribute'
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ArtistsController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: user.id } }

  describe "GET #index" do
    it "assigns all artists as @artists" do
      artist = Artist.create! valid_attributes
      get :index, {format: :json}, valid_session
      expect(assigns(:artists)).to eq([artist])
    end
  end

  describe "GET #show" do
    it "assigns the requested artist as @artist" do
      artist = Artist.create! valid_attributes
      get :show, {:id => artist.to_param}, valid_session
      expect(assigns(:artist)).to eq(artist)
    end
  end

  describe "GET #new" do
    it "assigns a new artist as @artist" do
      get :new, {}, valid_session
      expect(assigns(:artist)).to be_a_new(Artist)
    end
  end

  describe "GET #edit" do
    it "assigns the requested artist as @artist" do
      artist = Artist.create! valid_attributes
      get :edit, {:id => artist.to_param}, valid_session
      expect(assigns(:artist)).to eq(artist)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Artist" do
        expect {
          post :create, {:artist => valid_attributes}, valid_session
        }.to change(Artist, :count).by(1)
      end

      it "assigns a newly created artist as @artist" do
        post :create, {:artist => valid_attributes}, valid_session
        expect(assigns(:artist)).to be_a(Artist)
        expect(assigns(:artist)).to be_persisted
      end

      it "redirects to the created artist" do
        post :create, {:artist => valid_attributes}, valid_session
        expect(response).to redirect_to(Artist.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved artist as @artist" do
        post :create, {:artist => invalid_attributes}, valid_session
        expect(assigns(:artist)).to be_a_new(Artist)
      end

      it "re-renders the 'new' template" do
        post :create, {:artist => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        name: 'a new name for the artist'
      }}

      it "updates the requested artist" do
        artist = Artist.create! valid_attributes
        put :update, {:id => artist.to_param, :artist => new_attributes}, valid_session
        artist.reload
        expect(artist.name).to eq new_attributes[:name]
      end

      it "assigns the requested artist as @artist" do
        artist = Artist.create! valid_attributes
        put :update, {:id => artist.to_param, :artist => valid_attributes}, valid_session
        expect(assigns(:artist)).to eq(artist)
      end

      it "redirects to the artist" do
        artist = Artist.create! valid_attributes
        put :update, {:id => artist.to_param, :artist => valid_attributes}, valid_session
        expect(response).to redirect_to(artist)
      end
    end

    context "with invalid params" do
      it "assigns the artist as @artist" do
        artist = Artist.create! valid_attributes
        put :update, {:id => artist.to_param, :artist => invalid_attributes}, valid_session
        expect(assigns(:artist)).to eq(artist)
      end

      it "re-renders the 'edit' template" do
        artist = Artist.create! valid_attributes
        put :update, {:id => artist.to_param, :artist => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested artist" do
      artist = Artist.create! valid_attributes
      expect {
        delete :destroy, {:id => artist.to_param}, valid_session
      }.to change(Artist, :count).by(-1)
    end

    it "redirects to the artists list" do
      artist = Artist.create! valid_attributes
      delete :destroy, {:id => artist.to_param}, valid_session
      expect(response).to redirect_to(artists_url)
    end
  end
end
