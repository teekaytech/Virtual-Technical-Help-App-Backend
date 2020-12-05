class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.string :duration
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :engineer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
