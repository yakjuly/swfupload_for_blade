module AttachmentsHelper
  def use_swfupload
    text = javascript_include_tag("swfupload.js", "swfupload.fileprogress.js", "swfupload.handlers.js")
    text << stylesheet_link_tag("swfupload.css")
  end
  
  def swfupload(dom_id, attachable)
    javascript_tag( %(var swfu; window.onload = function(){ #{swfupload_js(dom_id, attachable)} };) )
  end
  
  def attachment_path_of(attachable)
    attachment_path(attachable.attachment, :attachable_type=>attachable.class, :attachable_id=>attachable.id)
  end

  def attach_link_of(attachable)
    return "" unless attachable.attachment 
    link_to attachable.attachment.file.original_filename, attachable.attachment.file.url, :target => "_blank"
  end

  def ext_img_of(attachment)
    image_tag("icons/file_#{attachment.ext_type}.png", :alt => attachment.ext_type)
  end

  def swfupload_js(dom_id, attachable, options = {})
    url = options[:url] || attachments_path(:attachable_type => attachable.class, :attachable_id => attachable.id)
    session_key = Rails.application.config.session_options[:key]
    url.add_query!(session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token)
    %(
      swfu = new SWFUpload({ 
        flash_url : "/flash/swfupload.swf",
        upload_url: "#{url}",	// Relative to the SWF file
   			post_params: {
   			  "#{key = Rails.application.config.session_options[:key]}" : "#{u cookies[key]}",
           "#{request_forgery_protection_token}"    : "#{u form_authenticity_token}"
   			},
   			file_size_limit : "100 MB",
   			file_types : "*.*", //上传类型控制"*.zip;*.doc;*.ppt;"
   			file_types_description : "All Files",
   			file_upload_limit : 100,   //上传容量大小
   			file_queue_limit : 1,     //上传数量
   			custom_settings : {
   				progressTarget : "fsUploadProgress"
   			},
   			// Button settings
        button_image_url : "/images/selectFile_17x18.png",
  			button_width: "130",
  			button_height: "18",
  			button_placeholder_id: "#{dom_id}",
  			button_text : '<span class="button">#{t :select_file}<span class="buttonSmall">( &lt; 100 MB)</span></span>',
        button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
  			button_text_left_padding: 15,
        button_text_top_padding: 3,
        button_cursor: SWFUpload.CURSOR.HAND,
        button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
   			// The event handler functions are defined in handlers.js
   			file_queued_handler : fileQueued,
 				file_queue_error_handler : fileQueueError,
 				file_dialog_complete_handler : fileDialogComplete,
 				upload_start_handler : uploadStart,
 				upload_progress_handler : uploadProgress,
 				upload_error_handler : uploadError,
 				upload_success_handler : uploadSuccess,
 				upload_complete_handler : uploadComplete,
 				queue_complete_handler : queueComplete	// Queue plugin
       });
     )
  end

  def swfupload_of(attachable)
    render :partial => "/attachments/single_upload", :locals => {:attachable => attachable}
  end
end