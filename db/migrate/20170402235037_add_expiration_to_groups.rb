class AddExpirationToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :expiration, :timestamp
  end
end
