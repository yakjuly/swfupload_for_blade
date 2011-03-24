class Comment < ActiveRecord::Base
  has_files
  
  validates :title, :presence => true
end
