module CurrentUserAware
  extend ActiveSupport::Concern

  attr_accessor :current_user
end
