class ChangeDatatypePostcodeOfPostImages < ActiveRecord::Migration[6.1]
  def change
    change_column :post_images, :postcode, :string
  end
end
