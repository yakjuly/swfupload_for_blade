require "fileutils"
class SwfuploadGenerator < Rails::Generator::NamedBase
  
  def manifest
    record do |m|
      m.migration_template "migration.rb", "db/migrate", :assigns => {
        :migration_name => "CreateAttachments"
      }, :migration_file_name => "create_attachments"
      
      m.directory File.join("app/views/attachments")
      m.directory File.join("app/helpers/attachments")
      m.directory File.join("app/controllers/attachments")
      m.directory File.join("app/models/attachment.rb")
      m.directory File.join("app/middleware")
      
      m.template '_upload.html.erb',  File.join("app/views/attachments/_single_upload.html.erb")
      m.template 'helper.rb',     File.join("app/helpers/attachments/attachments_helper.rb")
      m.template 'controller.rb', File.join("app/controllers/attachments/attachments_controller.rb")
      m.template 'attachment.rb', File.join('app/models/attachment.rb')
      m.template 'middleware.rb', File.join('app/middleware/flash_session_cookie_middleware.rb')
      m.template 'extensions.rb', File.join('lib/extensions.rb')
      m.template 'attachable.rb', File.join('lib/attachable.rb')
      
      
      
      FileUtils.cp_r File.expand_path(File.dirname(__FILE__) + "/templates/public"), File.join(Rails.root)
    end
  end
end