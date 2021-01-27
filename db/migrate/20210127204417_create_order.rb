class CreateOrder < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.bigint :user_id

      t.timestamps
    end
  end
end
