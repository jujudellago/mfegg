class AddPhotoCount < ActiveRecord::Migration
  def self.up
    add_column :galleries, :photos_count, :integer, :default=>0
    add_column :galleries, :default_photo_id, :integer
  end

  def self.down
    remove_column :galleries, :photos_count
    add_column :galleries, :default_photo_id, :integer
  end
end
