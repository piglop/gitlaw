class User < ActiveRecord::Base
  rolify
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :slug
  
  has_many :texts, inverse_of: :user
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def display_name
    name.presence || I18n.t(:anonmyous)
  end
end
