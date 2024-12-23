class AddColumnsToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :postcode, :integer
    add_column :post_images, :address, :string
  end
end
