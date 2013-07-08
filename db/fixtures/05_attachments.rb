# coding: utf-8

(1..3).each do |i|

  AttachmentCategory.seed(:id, {
      id: i,
      title: "Категория##{i}",
      description: Faker::Lorem::paragraph(5),
  },
  )

  AttachmentJobType.seed(:id, {
      id: i,
      title: "Тип работы##{i}",
      description: Faker::Lorem::paragraph(5),
  },
  )

end

(1..5).each do |i|
  Attachment.seed(:id, {
      id: i,
      attachment_category_id: rand(1..3),
      attachment_job_type_id: rand(1..3),
      title: "Файл##{i}",
      description: Faker::Lorem::paragraph(5),
      file: File.new('db/fixtures/files/sample.txt')
  },
  )
end
atts = Attachment.all
atts.each do |a|
  a.tcps << Tcp.first
end
attz = Attachmentization.all
attz.each do |a|
  a.through_attachmentable = a.attachmentable
  a.save!
end