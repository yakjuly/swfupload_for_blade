require "fileutils"

class SwfuploadGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  source_root File.expand_path('../templates', __FILE__)  
  
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end
  
  def generate_swfupload
    migration_template "migration.rb", "db/migrate/create_attachments.rb"
    
    copy_file '_upload.html.erb',  "app/views/attachments/_single_upload.html.erb"
    copy_file 'helper.rb',     "app/helpers/attachments_helper.rb"
    copy_file 'controller.rb', "app/controllers/attachments_controller.rb"
    copy_file 'model.rb', 'app/models/attachment.rb'
    copy_file 'middleware.rb', 'app/middleware/flash_session_cookie_middleware.rb'
    copy_file 'attachable.rb', 'lib/attachable.rb'
    
    directory "public", "public"
  end
end