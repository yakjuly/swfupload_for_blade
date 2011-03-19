class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :file_file_name, :null => false
      t.string :file_content_type, :null => false
      t.integer :file_file_size, :null => false
      t.datetime :file_updated_at, :null => false
      
      t.references :attachable, :polymorphic => true
      t.timestamps
    end
    
    add_index :attachments, [:attachable_id, :attachable_type]
    
  end

  def self.down
    drop_table :attachments
  end
end
