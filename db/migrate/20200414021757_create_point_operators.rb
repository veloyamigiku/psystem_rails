class CreatePointOperators < ActiveRecord::Migration
  def change
    create_table :point_operators do |t|
      t.string :name, index: { unique: true }
      t.string :password, null: false

      t.timestamps null: false
    end
  end
end
