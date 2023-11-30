class User < ApplicationRecord

    has_many :sessions
    has_many :tweets

    validates :username, length: {minimum: 3, maximum: 64}, prescence: true
    validates :password, length: {minimum: 8, maximum: 64}, prescence: true
    validates :email, length: {minimum: 5, maximum: 500}, prescence: true
    
end
