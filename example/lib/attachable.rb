module Attachable
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def has_files
      include Attachable::InstanceMethods
      has_many :attachments, :as => :attachable, :dependent => :destroy, :order => "created_at desc"
      
      before_update :set_attachable
    end

    def has_file
      include Attachable::InstanceMethods
      has_one :attachment, :as => :attachable, :dependent => :destroy, :order => "created_at desc"

      before_update :set_attachable
    end
  end
  
  module InstanceMethods
    
    def attachment_attributes=( attrs )
      @attachment_attributes = attrs
      
      if self.respond_to?(:attachments)
        attrs.each do |key, attr|
          self.attachments << Attachment.find_by_id(attr["id"])
        end
      else
        self.attachment = Attachment.find_by_id(attrs["id"])
      end
    end
    
    def attachment_attributes
      @attachment_attributes
    end
    
    def set_attachable
      original_attachments = Attachment.attached_by(self)
      
      if self.respond_to?(:attachments)
        need_destroy = original_attachments - self.attachments
      else
        need_destroy = original_attachments - [self.attachment]
      end
      
      need_destroy.each(&:destroy)
    end
  end
  
end
ActiveRecord::Base.send(:include, Attachable)