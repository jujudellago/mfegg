class AddPagesDetails < ActiveRecord::Migration
  def self.up
    add_column :pages, :keywords, :string
    add_column :pages, :description, :string
    add_column :pages, :enabled, :boolean
  end

  def self.down
    remove_column :pages, :enabled
    remove_column :pages, :description
    remove_column :pages, :keywords
  end
end



