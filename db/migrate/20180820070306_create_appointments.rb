class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.date :appointment_date
      t.references :department
      t.references :doctor
      t.references :patient
      t.references :time_slot

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
