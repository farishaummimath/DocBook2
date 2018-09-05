class CreateMedicalRecords < ActiveRecord::Migration
  def self.up
    create_table :medical_records do |t|
      t.references :patient
      t.references :doctor
      t.string :medication_given
      t.string :comments
      t.boolean :recommended_to_admit

      t.timestamps
    end
  end

  def self.down
    drop_table :medical_records
  end
end
