class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :title
      t.string :password_digest
      t.integer :expiration
      t.timestamps
    end
  end
end
