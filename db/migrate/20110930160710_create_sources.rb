class CreateSources < ActiveRecord::Migration
  def change
    create_table  :sources do |t|
      t.interger  :provider_id
      t.string    :website_url
      t.string    :type
      t.string    :push_url 
      t.timestamps
    end
  end
end
