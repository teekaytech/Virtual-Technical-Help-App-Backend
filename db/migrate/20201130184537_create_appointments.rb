class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.string :session
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :engineer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
