class User < ActiveRecord::Base

    has_many :articles, dependent: :destroy
    before_save { self.email = email.downcase }
    
    validates :username, presence: true, length: {minimum: 3, maximum: 20 }
    validates :email, presence: true, length: {minimum: 6, maximum: 100 }
    
    has_secure_password

end