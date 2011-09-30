class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :email
      t.string :api_key 
      
      t.timestamps
    end
  end
end
