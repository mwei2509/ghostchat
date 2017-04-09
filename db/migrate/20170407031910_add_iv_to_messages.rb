class AddIvToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :iv, :bytea
  end
end
