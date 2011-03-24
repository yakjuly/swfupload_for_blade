class AttachmentsController < ApplicationController
  
  def create
    @attachment = Attachment.new(:swf_uploaded_data => params[:Filedata], :attachable => @attachable)
    @attachment.save!
    
    render :json => {
      :attachment_id    => @attachment.id, 
      :url              => @attachment.file.url, 
      :filename         => @attachment.file.original_filename,
      :attachable_type  => params[:attachable_type],
      :attachable_id    => params[:attachable_id]
    }
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    if request.xhr?
      render :update do |page|
        if @attachable
          page.call "$('#uploadContainer').replaceWith", render(:partial => "single_upload", :locals => {:attachable => @attachable})
          page << swfupload_js("upload-button", @attachable)
        else
          page << "$($('#attachment_#{@attachment.id}').parents()[1]).remove()"
        end
      end
    else
      render :nothing => true
    end
  end
  
  private
  
end