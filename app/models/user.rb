class User < ActiveRecord::Base 
  include Sluggable

  has_many :posts 
  has_many :comments 
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  has_secure_password validations: false

  sluggable_column :username

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # sets random 6 digit number as pin
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'AC766e67ad6d3bd4c1663466526e8c6944' 
    auth_token = '09865a916759c23438be816e1a10c874' 
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
    
    msg = "Hi, please input the pin to continue login: #{self.pin}" 
    client.account.messages.create({
      :from => '+17149759782', 
      :to => "#{self.phone}", 
      :body => msg  
    })
  end

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role == 'moderator'
  end
end