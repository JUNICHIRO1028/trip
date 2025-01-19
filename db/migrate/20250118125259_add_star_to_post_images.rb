class AddStarToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :star, :string
  end
end
