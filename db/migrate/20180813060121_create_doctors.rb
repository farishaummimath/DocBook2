class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :contact_number
      t.string :email
      t.string :gender
      t.string :nationality
      t.string :qualifications
      t.string :experience
      t.references :user
      t.references :department

      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
