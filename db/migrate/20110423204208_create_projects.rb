class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title, :null => false
      t.string :url
      t.string :status, :null => false
      t.date :funded_at, :null => false
      t.integer :chapter_id, :unsigned => true
      t.timestamps
      t.text :description, :null => false
    end
    
    add_index :projects, [:chapter_id, :status, :funded_at]
  end

  def self.down
    drop_table :projects
  end
end
