# coding: utf-8

(1..10).each do |i|
  Post.seed(:id, {
      id: i,
      title: "Новость##{i}",
      short_description: Faker::Lorem::paragraph(3),
      description: Faker::Lorem::paragraph(10),
  },
  )
end