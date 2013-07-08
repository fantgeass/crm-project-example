# coding: utf-8

Role.seed(:id,
  { name: 'admin'},
  { name: 'user' }
)

(1..5).each do |i|
  Department.seed(:id, {
      title: "Департамент##{i}",
      description: Faker::HipsterIpsum::paragraph(5),
  },
  )

  Position.seed(:id, {
      title: "Должность##{i}",
      description: Faker::HipsterIpsum::paragraph(5),
  },
  )
end


# We have 7 users
User.seed(:id,
  { id: 1,
    company_id: 1,
    department_id: 1,
    position_id: 1,
    fullname: 'Админ Админов',
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    gender: :man,
    phone: Faker::PhoneNumber::short_phone_number,
    about: Faker::HipsterIpsum::paragraph(5),
    date_of_birth: Time.now - 20.years },

  { id: 2,
    company_id: 1,
    department_id: 1,
    position_id: 1,
    fullname: 'Демо Демов',
    email: 'demo@example.com',
    password: 'password',
    password_confirmation: 'password',
    phone: Faker::PhoneNumber::short_phone_number,
  }
)

(1..5).each do
  User.seed(:id, {
    company_id: rand(1..5),
    department_id: rand(1..5),
    position_id: rand(1..5),
    fullname: Faker::Name::name,
    email: Faker::Internet::email,
    phone: Faker::PhoneNumber::short_phone_number,
    password: 'password',
    password_confirmation: 'password',
  },
  )
end


User.find(1).add_role :admin
User.find(2).add_role :user