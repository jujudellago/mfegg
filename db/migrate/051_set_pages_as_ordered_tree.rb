class SetPagesAsOrderedTree < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer, :default => 0
    add_column :pages, :position, :integer, :default => 1
    welcome=Page.find(:first)
    welcome.position=0
    welcome.save!
  
  end

  def self.down
    remove_column :pages, :parent_id
    remove_column :pages, :position
  end
end
