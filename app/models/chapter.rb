class Chapter < ActiveRecord::Base
  
  has_many :trustees, :class_name => User.name
  
  has_many :projects
  
  def to_param
    slug
  end
  
end