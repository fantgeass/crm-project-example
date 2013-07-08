class PostsController < ResourceController

  has_scope :order, default: 'id DESC'
  has_scope :page, default: 1
  has_scope :per, default: 5

end