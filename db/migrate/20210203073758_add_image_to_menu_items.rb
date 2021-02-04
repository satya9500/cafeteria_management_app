class AddImageToMenuItems < ActiveRecord::Migration[6.1]
  def change
    add_column :menu_items, :image, :string
  end
end
