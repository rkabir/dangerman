class User < ActiveRecord::Base
  attr_accessible :uid, :username, :password, :password_hint

end
