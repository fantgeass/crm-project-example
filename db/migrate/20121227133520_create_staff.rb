class CreateStaff < ActiveRecord::Migration
  def change
    create_table :staff do |t|
      t.references :staffable, polymorphic: true
      t.references :staff_role
      t.references :user

      t.timestamps
      t.userstamps
    end

    create_table :staff_roles do |t|
      t.string :title
      t.text   :description

      t.timestamps
      t.userstamps
    end
  end
end
