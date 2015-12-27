describe UsersController do
  let(:default_params) {{
    name: 'foobar',
    email: 'foo@example.com',
    password: 'goodenuf',
    password_confirmation: 'goodenuf'
  }}

  it 'should render the new user creation form' do
    get 'new'
    expect(response).to render_template(:new)
  end

  it 'should redirect to the root' do
    post 'create', user: default_params
    expect(response).to redirect_to root_path
  end

  it 'should redirect to the signup_path if name is not given' do
    post 'create', user: default_params.except(:name)
    expect(response).to render_template(:new)
    expect(assigns(:user).errors[:name]).to eq ["can't be blank", "is too short (minimum is 1 character)"]
  end

  it 'should redirect to the signup_path if email is not given' do
    post 'create', user: default_params.except(:email)
    expect(response).to render_template(:new)
    expect(assigns(:user).errors[:email]).to eq ["can't be blank"]
  end

  it 'should raise an error if the user param is not given' do
    expect{post 'create'}.to raise_error(ActionController::ParameterMissing)
  end
end
