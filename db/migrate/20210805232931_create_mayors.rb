class CreateMayors < ActiveRecord::Migration[6.1]
  def change
    create_table :mayors do |t|
      t.string :name
      t.string :gender
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
