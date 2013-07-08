object @comment
attributes :id, :parent_id, :body, :created_at, :updated_at, :creator_avatar_url
glue(:creator) { attribute to_s: :creator }
child :attachments do
  extends 'attachments/model'
end
