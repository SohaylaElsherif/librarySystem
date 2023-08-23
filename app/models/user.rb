class User < ApplicationRecord
  include UsersHelper

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  
  self.inheritance_column = :user_type

  has_many :borrow_histories
  has_many :reviews
  has_many :notifications
  validate :password_complexity
  before_create :generate_otp


end
