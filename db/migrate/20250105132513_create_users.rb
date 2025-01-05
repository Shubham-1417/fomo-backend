class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :pseudonym
      t.string :password_digest
      t.text :bio

      t.timestamps
    end
    add_index :users, :pseudonym, unique: true
  end
end
