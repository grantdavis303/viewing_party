class User < ApplicationRecord
  validates_presence_of :name, :email, :password_digest
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :user_parties
  has_many :viewing_parties, through: :user_parties
  
  has_secure_password
end
