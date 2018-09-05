class CreateTimeSlots < ActiveRecord::Migration
  def self.up
    create_table :time_slots do |t|
      t.time :start_time
      t.time :end_time
      t.references :doctor

      t.timestamps
    end
  end

  def self.down
    drop_table :time_slots
  end
end
