class Attachment < ActiveRecord::Base
  
  has_attached_file :file, 
    :path => ":rails_root/public/system/:class/:id/:basename.:extension", 
    :url => "/system/:class/:id/:basename.:extension"
  
  belongs_to :attachable, :polymorphic => true
  
  scope :attached_by, lambda {|attachable| where(:attachable_type => attachable.class, :attachable_id => attachable.id)}
  
  # Map file extensions to mime types.
  # Thanks to bug in Flash 8 the content type is always set to application/octet-stream.
  # From: http://blog.airbladesoftware.com/2007/8/8/uploading-files-with-swfupload
  def swf_uploaded_data=(data)
    data.content_type = MIME::Types.type_for(data.original_filename)
    self.file = data
  end
  
  def ext
    file.original_filename.split(".").last
  end
  
  def ext_type
    case ext
    when "png", "jpg", "bmp"
      "img"
    when "pptx", "ppt"
      "ppt"
    when "docx", "doc"
      "doc"
    when "rar", "zip"
      "zip"
    else
      "unknown"
    end
  end
end
