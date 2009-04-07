class AddPositionToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :left, :integer
    add_column :notes, :top, :integer
  end

  def self.down
    remove_column :notes, :left
    remove_column :notes, :top
  end
end
