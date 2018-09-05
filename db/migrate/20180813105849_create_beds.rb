class CreateBeds < ActiveRecord::Migration
  def self.up
    create_table :beds do |t|
      t.string :bed_number
      t.references :room

      t.timestamps
    end
  end

  def self.down
    drop_table :beds
  end
end
