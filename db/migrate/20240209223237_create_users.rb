class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid  do |t|
      t.string :email
      t.string :password_digest
      t.string :lastname
      t.string :firstname
      t.string :adress
      t.integer :role
      t.boolean :email_confirmed, :default => false
      t.string :confirm_token
      t.string :password_reset_token
      t.string :bio
      t.string :image

      t.timestamps
    end
  end
end
