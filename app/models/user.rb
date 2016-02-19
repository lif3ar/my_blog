class User < ActiveRecord::Base
    
    has_many :articles, dependent: :destroy
    
    validates :username, presence: true, length: {minimum: 3, maximum: 20 }
    validates :email, presence: true, length: {minimum: 6, maximum: 20 } 

end
