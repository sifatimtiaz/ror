class Question < ActiveRecord::Base

  validates_presence_of :fullname
  validates_presence_of :email
  validates_presence_of :comments
  
end
