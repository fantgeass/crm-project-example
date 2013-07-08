# == Schema Information
#
# Table name: tasks
#
#  id                    :integer          not null, primary key
#  taskable_id           :integer
#  taskable_type         :string(255)
#  title                 :string(255)
#  description           :text
#  planned_start_date    :date
#  planned_complete_date :date
#  priority              :string(255)
#  is_complete           :boolean          default(FALSE), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  creator_id            :integer
#  updater_id            :integer
#

class Task < AbstractActiveRecord
  include Taskable

  attr_accessible :to_task_ids, :from_task_ids

  belongs_to :taskable, polymorphic: true

  # tasks that bounds to this task
  has_and_belongs_to_many :to_tasks,
                          class_name: self.name,
                          foreign_key: 'to_task_id',
                          association_foreign_key: 'from_task_id',
                          join_table: 'tasks_relations'

  # tasks that have bound from this task
  has_and_belongs_to_many :from_tasks,
                          class_name: self.name,
                          foreign_key: 'from_task_id',
                          association_foreign_key: 'to_task_id',
                          join_table: 'tasks_relations'

  validates_presence_of :users

  before_save ThroughAttachmentableCallbacks.new(:taskable)

  def related_tasks
    (to_tasks + from_tasks).flatten.uniq
  end


end
