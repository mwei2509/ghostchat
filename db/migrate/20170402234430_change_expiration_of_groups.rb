class ChangeExpirationOfGroups < ActiveRecord::Migration[5.0]
  def change
    remove_column :groups, :expiration, :timestamp
  end
end
