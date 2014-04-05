class DeleteShortFromUrls < ActiveRecord::Migration
  def change
    remove_column :urls, :short
  end
end
