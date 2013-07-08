class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def change

    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.text :body, default: ""
      t.integer :parent_id, :lft, :rgt

      t.timestamps
      t.userstamps
    end

    add_index :comments, :commentable_id
  end
end
