class RemoveColumnsToPostImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_images, :address, :string
    remove_column :post_images, :lat, :float
    remove_column :post_images, :lng, :float
  end
end
