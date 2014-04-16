class Banner < ActiveRecord::Base
  validates_presence_of :imagename
  belongs_to :movie
end