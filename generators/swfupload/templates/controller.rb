class AttachmentsController < ApplicationController
  before_filter :login_required
  before_filter :find_attachable, :only => [:create, :destroy]
  
  def create
    Attachment.attached_by(@attachable).each(&:destroy) if @attachable.respond_to?(:attachment)
    @attachment = Attachment.new(:swf_uploaded_data => params[:Filedata], :attachable => @attachable)
    @attachment.save!
    render :json => {
      :attachment_id    => @attachment.id, 
      :attachable_type  => @attachable.class.name, 
      :attachable_id    => @attachable.id, 
      :url              => @attachment.file.url, 
      :filename         => @attachment.file.original_filename
    }
  end
  
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    if request.xhr?
      render :update do |page|
        page.call "$('#uploadContainer').replaceWith", render(:partial => "single_upload", :locals => {:attachable => @attachable})
        page << swfupload_js("upload-button", @attachable)
      end
    else
      render :nothing => true
    end
  end
  
  private
  
  def find_attachable
    klass = params[:attachable_type].constantize
    @attachable = klass.send(:with_exclusive_scope){ klass.find(params[:attachable_id]) }
  end
  
end
