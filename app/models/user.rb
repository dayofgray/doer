class User < ActiveRecord::Base
    has_secure_password
    has_many :tasks

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end