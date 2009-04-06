class AddStatusToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :status, :string
  end

  def self.down
    remove_column :notes, :status
  end
end
