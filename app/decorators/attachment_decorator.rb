class AttachmentDecorator < ApplicationDecorator

  def file_size
    number_to_human_size(source.file.size)
  end

  def file_icon
    '/assets/attachments-icons/file.png'
  end

end
