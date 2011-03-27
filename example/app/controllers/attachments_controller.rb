class AttachmentsController < ApplicationController
  
  def create
    @attachment = Attachment.new(:swf_uploaded_data => params[:Filedata])
    @attachment.save!
    
    render :json => {
      :attachment_id    => @attachment.id, 
      :url              => @attachment.file.url, 
      :filename         => @attachment.file.original_filename,
      :attachable_type  => params[:attachable_type],
      :attachable_id    => params[:attachable_id]
    }
  end
  
end