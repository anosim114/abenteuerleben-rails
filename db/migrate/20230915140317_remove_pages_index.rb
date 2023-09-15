class RemovePagesIndex < ActiveRecord::Migration[7.0]
  def change
    remove_index :pages, :url, unique: true
  end
end
