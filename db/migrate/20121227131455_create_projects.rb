class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects, id: false do |t|
      t.integer :id, null: false # belongs to tcp
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
    execute "ALTER TABLE projects ADD PRIMARY KEY (id);"
  end
end
