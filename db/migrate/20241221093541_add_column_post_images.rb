class AddColumnPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :latitude, :float
    add_column :post_images, :longitude, :float
  end
end
