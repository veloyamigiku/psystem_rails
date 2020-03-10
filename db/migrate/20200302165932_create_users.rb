class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, index: { unique: true }
      t.string :password
      t.string :username

      t.timestamps null: false
    end
  end
end
