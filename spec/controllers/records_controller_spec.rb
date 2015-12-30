require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
render_views
  
  let(:user) { new_user }

  # This should return the minimal set of attributes required to create a valid
  # Record. As you add validations to Record, be sure to adjust the attributes here as well.
  let(:valid_attributes) {{
    title: 'a title', user_id: user.id
  }}

  let(:invalid_attributes) {{
    title: ''
  }}

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # RecordsController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: user.id } }

  describe "GET #index" do
    it "assigns all records as @records" do
      record = Record.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:records)).to eq([record])
    end
  end

  describe "GET #show" do
    it "assigns the requested record as @record" do
      record = Record.create! valid_attributes
      get :show, {:id => record.to_param}, valid_session
      expect(assigns(:record)).to eq(record)
    end
  end

  describe "GET #new" do
    it "assigns a new record as @record" do
      get :new, {}, valid_session
      expect(assigns(:record)).to be_a_new(Record)
    end
  end

  describe "GET #edit" do
    it "assigns the requested record as @record" do
      record = Record.create! valid_attributes
      get :edit, {:id => record.to_param}, valid_session
      expect(assigns(:record)).to eq(record)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Record" do
        expect {
          post :create, {:record => valid_attributes}, valid_session
        }.to change(Record, :count).by(1)
      end

      it "assigns a newly created record as @record" do
        post :create, {:record => valid_attributes}, valid_session
        expect(assigns(:record)).to be_a(Record)
        expect(assigns(:record)).to be_persisted
      end

      it "redirects to the created record" do
        post :create, {:record => valid_attributes}, valid_session
        expect(response).to redirect_to(Record.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved record as @record" do
        post :create, {:record => invalid_attributes}, valid_session
        expect(assigns(:record)).to be_a_new(Record)
      end

      it "re-renders the 'new' template" do
        post :create, {:record => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{
        title: 'a brand new title for my record'
      }}

      it "updates the requested record" do
        record = Record.create! valid_attributes
        put :update, {:id => record.to_param, :record => new_attributes}, valid_session
        record.reload
        expect(record.title).to eq new_attributes[:title]
      end

      it "assigns the requested record as @record" do
        record = Record.create! valid_attributes
        put :update, {:id => record.to_param, :record => valid_attributes}, valid_session
        expect(assigns(:record)).to eq(record)
      end

      it "redirects to the record" do
        record = Record.create! valid_attributes
        put :update, {:id => record.to_param, :record => valid_attributes}, valid_session
        expect(response).to redirect_to(record)
      end
    end

    context "with invalid params" do
      it "assigns the record as @record" do
        record = Record.create! valid_attributes
        put :update, {:id => record.to_param, :record => invalid_attributes}, valid_session
        expect(assigns(:record)).to eq(record)
      end

      it "re-renders the 'edit' template" do
        record = Record.create! valid_attributes
        put :update, {:id => record.to_param, :record => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let(:record) do
      Record.create!(valid_attributes.merge(user_id: user.id)).tap do |r|
        r.current_user = user
        r.mark_as_favorite!
      end
    end

    it "destroys the requested record" do
      record_id = record.id
      expect {
        delete :destroy, {:id => record_id}, valid_session
      }.to change(Record, :count).by(-1)
    end

    it "redirects to the records list" do
      record_id = record.id
      delete :destroy, {:id => record_id}, valid_session
      expect(response).to redirect_to(records_url)
    end
  end
end
