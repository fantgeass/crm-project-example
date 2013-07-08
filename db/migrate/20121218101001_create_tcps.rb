class CreateTcps < ActiveRecord::Migration
  def change
    create_table :tcps do |t|
      t.references :company
      t.references :client

      t.string :title
      t.text :description
      t.string :state
      t.date   :complete_date
      t.date   :planned_start_date
      t.date   :planned_complete_date

      t.timestamps
      t.userstamps
    end
  end
end
