class AddPhotosToProjects < ActiveRecord::Migration
  def self.up    
    change_table :projects do |t|
      t.column :photo_file_name,    :string
      t.column :photo_content_type, :string
      t.column :photo_file_size,    :integer
      t.column :photo_updated_at,   :datetime
    end
  end

  def self.down
    change_table :projects do |t|
      t.remove :photo_file_name
      t.remove :photo_content_type
      t.remove :photo_file_size 
      t.remove :photo_updated_at
    end
  end
end
