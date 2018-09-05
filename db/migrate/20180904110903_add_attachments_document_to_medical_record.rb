class AddAttachmentsDocumentToMedicalRecord < ActiveRecord::Migration
  def self.up
    add_column :medical_records, :document_file_name, :string
    add_column :medical_records, :document_content_type, :string
    add_column :medical_records, :document_file_size, :integer
    add_column :medical_records, :document_updated_at, :datetime
  end

  def self.down
    remove_column :medical_records, :document_file_name
    remove_column :medical_records, :document_content_type
    remove_column :medical_records, :document_file_size
    remove_column :medical_records, :document_updated_at
  end
end
