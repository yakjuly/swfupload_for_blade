module Attachable
  
  def self.included(base)
    base.class_eval do
      has_one :attachment, :as => :attachable, :dependent => :destroy, :order => "created_at desc"
    end
  end
  
end