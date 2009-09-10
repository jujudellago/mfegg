class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.column :name, :string
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.column :description, :text
    end
  end

  def self.down
    drop_table :galleries
  end
end
