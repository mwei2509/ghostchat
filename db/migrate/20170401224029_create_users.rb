class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :group_id
      t.string :username
      t.boolean :is_creator
      t.timestamps
    end
  end
end
