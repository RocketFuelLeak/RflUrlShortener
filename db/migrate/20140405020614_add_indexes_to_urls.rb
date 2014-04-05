class AddIndexesToUrls < ActiveRecord::Migration
  def change
    add_index :urls, :long, unique: true
    add_index :urls, :short, unique: true
  end
end
