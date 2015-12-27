class User < ActiveRecord::Base
  has_secure_password

  validates :password,
    :length => { minimum: 8, if: :validate_password? },
    :confirmation => { if: :validate_password? }
  validates :email, 
    :presence => true,
    :uniqueness => true
  validates :name, 
    :presence => true, 
    :length => { minimum: 1 }

private
  def validate_password?
    new_record? || (password.present? || password_confirmation.present?)
  end
end
