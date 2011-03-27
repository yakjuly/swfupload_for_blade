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
      @need_destroy_attachments = []
      
      attrs.each do |id, action|
        attach = Attachment.find_by_id(id)
        if action["create"] == "true"
          if self.respond_to?(:attachments)
            unless self.attachments.include?(attach)
              self.attachments << attach
            end
          else
            unless self.attachment == attach
              self.attachment = attach
            end
          end
        elsif action["delete"] == "true"
          @need_destroy_attachments << attach
        end
      end
    end
    
    def attachment_attributes
      @attachment_attributes
    end
    
    def set_attachable
      if @need_destroy_attachments.present?
        @need_destroy_attachments.each(&:destroy)
      end
    end
  end
  
end
ActiveRecord::Base.send(:include, Attachable)