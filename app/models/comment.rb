# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  body             :text
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  creator_id       :integer
#  updater_id       :integer
#

class Comment < AbstractActiveRecord
  attr_accessible :body, :parent_id, :attachment_ids
  acts_as_nested_set scope: [:commentable_id, :commentable_type]

  validates_presence_of :body

  belongs_to :commentable, polymorphic: true
  has_many :attachmentizations, as: :attachmentable #
  has_many :attachments, through: :attachmentizations

  before_save ThroughAttachmentableCallbacks.new(:projectable)

  # get tcp/project that comment is belong to (maybe through another model like task or question)
  def projectable
    return commentable             if commentable.class.included_modules.include?(Projectable)
    return commetable.taskable     if commentable.is_a?(Task)
    return commetable.questionable if commentable.is_a?(Question)
  end

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, comment)
    c = self.new
    c.commentable_id = obj.id
    c.commentable_type = obj.class.base_class.name
    c.body = comment
    c
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.size > 0
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:creator_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
end
