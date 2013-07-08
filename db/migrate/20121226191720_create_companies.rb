class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title
      t.text   :description
      t.string :address

      t.timestamps
      t.userstamps
    end
  end
end
