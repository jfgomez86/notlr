class AddDeletedAtToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :deleted_at, :datetime
  end

  def self.down
    remove_column :notes, :deleted_at
  end
end
