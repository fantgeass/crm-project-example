class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :short_description
      t.text :description

      t.timestamps
      t.userstamps
    end
  end
end
