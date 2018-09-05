class CreateBedallocations < ActiveRecord::Migration
  def self.up
    create_table :bedallocations do |t|
      t.references :room
      t.references :bed
      t.string :comments
      t.references :patient

      t.timestamps
    end
  end

  def self.down
    drop_table :bedallocations
  end
end
