class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
<<<<<<< HEAD
  validates :zipcode, presence: true
=======
>>>>>>> 7eef255614a339e4d73edd8d9c60f426e9da9e70
	validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true


	has_many :house_users
	has_many :houses, through: :house_users
	has_secure_password

	has_many :pictures
end
