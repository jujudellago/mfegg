class CreatePages < ActiveRecord::Migration 
  def self.up 
    create_table :pages do |t| 
      t.column :title, :string 
      t.column :permalink, :string 
      t.column :body, :text 
      t.column :created_at, :datetime 
      t.column :updated_at, :datetime 
    end 
    Page.create(:title => "Male+Female=Egg", 
                :permalink => "welcome-page", 
                :body => "Bienvenue sur Male+Female=Egg") 
    
  end 
  def self.down 
    drop_table :pages 
  end 
end