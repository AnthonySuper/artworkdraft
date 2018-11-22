class CreateUsers < ActiveRecord::Migration[5.2]
  def change

    enable_extension 'citext'

    create_table :users do |t|
      t.citext :name, null: false
      t.citext :email, null: false
      t.text :bio, null: false, default: ""
      t.text :password_digest, null: false

      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :email, unique: true
  end
end
