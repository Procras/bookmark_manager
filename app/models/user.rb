require 'bcrypt'


class User
  attr_reader :password
  attr_accessor :password_confirmation

# include BCrypt

include DataMapper::Resource

property :id, Serial
property :email_address, String
property :password_digest, String, length: 60

validates_confirmation_of :password


  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
