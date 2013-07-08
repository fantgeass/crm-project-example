class CreateTasksAndQuestions < ActiveRecord::Migration
  def change
    create('tasks', 'taskable')
    create('questions', 'questionable')

    create_table 'tasks_relations', id: false do |t|
      t.references :to_task
      t.references :from_task
    end
  end

  private

  def create(table, polymorphic_name)
    create_table table do |t|
      t.references polymorphic_name, polymorphic: true

      t.string :title
      t.text :description
      t.date :planned_start_date
      t.date :planned_complete_date
      t.string :priority
      t.boolean :is_complete, default: false, null: false

      t.timestamps
      t.userstamps
    end
  end

end
