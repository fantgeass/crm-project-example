# coding: utf-8

(1..5).each do |i|

  Company.seed(:id, {
      id: i,
      title: "Компания##{i}",
      description: Faker::Lorem::paragraph(20),
      address: Faker::Address::street_address(true)
  },
  )

end

