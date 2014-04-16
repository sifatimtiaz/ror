class Registration < ActiveRecord::Base
  belongs_to :event
  
  validates_presence_of :fullname
  validates_presence_of :company
  validates_presence_of :phone
  validates_presence_of :email
end
