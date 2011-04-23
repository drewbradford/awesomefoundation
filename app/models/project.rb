class Project < ActiveRecord::Base
  has_attached_file :photo, :styles => {:thumb => '50x50>'}
  
  STATUSES = %w( unannounced announced )
  
  belongs_to :chapter
  
  validates_presence_of :title
  validates_presence_of :funded_at
  validates_presence_of :description
  validates_attachment_presence :photo, :if => Proc.new { |project| project.status == 'announced' }
  
  validates_inclusion_of :status, :in => STATUSES, :allow_nil => false
  
  named_scope :unannounced, :conditions => { :status => 'unannounced' }
  named_scope :announced, :conditions => { :status => 'announced' }
end
