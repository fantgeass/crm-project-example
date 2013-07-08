class Post < AbstractActiveRecord
  attr_accessible :description, :short_description, :title

  validates_presence_of :title, :description, :short_description
  validates_length_of :short_description, maximum: 500
end
