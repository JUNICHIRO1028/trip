class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|

      t.integer :user_id
      t.string :title
      t.text :body

      t.string :address
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
