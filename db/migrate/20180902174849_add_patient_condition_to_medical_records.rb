class AddPatientConditionToMedicalRecords < ActiveRecord::Migration
  def self.up
    add_column :medical_records, :patient_condition, :string
  end

  def self.down
    remove_column :medical_records, :patient_condition
  end
end
