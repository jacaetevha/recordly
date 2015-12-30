require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let(:user) { new_user }
  let(:record) { Record.create title: 'a record', user_id: user.id }

  # This should return the minimal set of attributes required to create a valid
  # Song. As you add validations to Song, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {{
    title: 'a song title', record_id: record.id
  }}

  let(:invalid_attributes) {{
    title: ''
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SongsController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: user.id } }

  describe "GET #show" do
    it "assigns the requested song as @song" do
      song = Song.create! valid_attributes
      get :show, {record_id: record.id, id: song.to_param}, valid_session
      expect(assigns(:song)).to eq(song)
    end
  end

  describe "GET #new" do
    it "assigns a new song as @song" do
      get :new, {record_id: record.id}, valid_session
      expect(assigns(:song)).to be_a_new(Song)
    end
  end

  describe "GET #edit" do
    it "assigns the requested song as @song" do
      song = Song.create! valid_attributes
      get :edit, {record_id: record.id, id: song.to_param}, valid_session
      expect(assigns(:song)).to eq(song)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Song" do
        expect {
          post :create, {record_id: record.id, song: valid_attributes}, valid_session
        }.to change(Song, :count).by(1)
      end

      it "assigns a newly created song as @song" do
        post :create, {record_id: record.id, song: valid_attributes}, valid_session
        expect(assigns(:song)).to be_a(Song)
        expect(assigns(:song)).to be_persisted
      end

      it "redirects to the created song" do
        post :create, {record_id: record.id, song: valid_attributes}, valid_session
        expect(response).to redirect_to(record)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved song as @song" do
        post :create, {record_id: record.id, song: invalid_attributes}, valid_session
        expect(assigns(:song)).to be_a_new(Song)
      end

      it "re-renders the 'new' template" do
        post :create, {record_id: record.id, song: invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        title: 'a brand new song title'
      }}

      it "updates the requested song" do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, record_id: record.id, song: new_attributes}, valid_session
        song.reload
        expect(song.title).to eq new_attributes[:title]
      end

      it "assigns the requested song as @song" do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, record_id: record.id, song: valid_attributes}, valid_session
        expect(assigns(:song)).to eq(song)
      end

      it "redirects to the song" do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, record_id: record.id, song: valid_attributes}, valid_session
        expect(response).to redirect_to(record)
      end
    end

    context "with invalid params" do
      it "assigns the song as @song" do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, record_id: record.id, song: invalid_attributes}, valid_session
        expect(assigns(:song)).to eq(song)
      end

      it "re-renders the 'edit' template" do
        song = Song.create! valid_attributes
        put :update, {id: song.to_param, record_id: record.id, song: invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested song" do
      song = Song.create! valid_attributes
      expect {
        delete :destroy, {record_id: record.id, id: song.to_param}, valid_session
      }.to change(Song, :count).by(-1)
    end

    it "redirects to the songs list" do
      song = Song.create! valid_attributes
      delete :destroy, {record_id: record.id, id: song.to_param}, valid_session
      expect(response).to redirect_to(record_url(record))
    end
  end

end
