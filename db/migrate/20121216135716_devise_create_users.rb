class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.references :company
      t.references :department
      t.references :position

      # paperclip
      t.attachment :avatar

      ## Database authenticatable
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      # custom attributes
      t.string  :fullname
      t.string  :gender
      t.string  :phone
      t.text    :about
      t.date    :date_of_birth
      t.decimal :salary

      t.timestamps
      t.userstamps
    end

    create_table :userizations, id: false do |t|
      t.references :userable, polymorphic: true
      t.references :user
    end

    create_table :departments do |t|
      t.string :title
      t.string :description
      t.timestamps
      t.userstamps
    end

    create_table :positions do |t|
      t.string :title
      t.string :description
      t.timestamps
      t.userstamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

  end
end
