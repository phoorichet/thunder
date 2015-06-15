class User < ActiveRecord::Base
  # Include default devise modules.
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable,
  #         :confirmable, :omniauthable

  # https://github.com/lynndylanhurley/devise_token_auth#example-disable-email-confirmation
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :session_limitable, :expirable

  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :workings
  has_many :companies, through: :workings

  before_validation do
    self.uid = email if uid.blank?
  end

end
