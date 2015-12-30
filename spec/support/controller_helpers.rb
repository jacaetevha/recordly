module ControllerHelpers
  def new_user(**options)
    defaults = {name: 'foo', email: 'foo@example.com', password: 'password', password_confirmation: 'password'}
    User.create! defaults.merge(options)
  end

  def sign_in(user = double('user'))
    if user.nil?
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
