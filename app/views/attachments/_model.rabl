object @attachment
attributes :id, :title, :attachment_category_title, :attachment_job_type_title
node(:file_size) { |a| a.file_size }
node(:file_icon) { |a| a.file_icon }
node(:file_url) { |a| a.file.url }