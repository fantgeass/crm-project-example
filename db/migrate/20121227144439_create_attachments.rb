class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :attachment_category
      t.references :attachment_job_type

      t.string :title
      t.text :description
      t.date :start_date
      t.date :finish_date
      t.boolean :accessible
      t.attachment :file

      t.timestamps
      t.userstamps
    end

    create_table :attachmentizations do |t|
      t.references :attachmentable, polymorphic: true
      t.references :through_attachmentable, polymorphic: true
      t.references :attachment

      t.timestamps
      t.userstamps
    end

    create_table :attachment_categories do |t|
      t.string :title
      t.text   :description

      t.timestamps
      t.userstamps
    end

    create_table :attachment_job_types do |t|
      t.string :title
      t.text   :description

      t.timestamps
      t.userstamps
    end
  end
end
