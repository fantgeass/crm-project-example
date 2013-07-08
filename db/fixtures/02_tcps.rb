# coding: utf-8

Tcp.seed(:id,
  { id: 1, company_id: 1, client_id: 1, title: 'Автоматизация предприятия', description: Faker::Lorem::paragraph(20),
    state: :active, planned_start_date: Date.yesterday, planned_complete_date: 3.weeks.from_now },

  { id: 2, company_id: 1, client_id: 1, title: 'Постройка генератора', description: Faker::Lorem::paragraph(20),
    state: :closed, planned_start_date: 3.months.ago, planned_complete_date: 2.weeks.ago },

  { id: 3, company_id: 1, client_id: 1, title: 'Ремонт завода', description: Faker::Lorem::paragraph(20),
    state: :completed, planned_start_date: 3.months.ago, planned_complete_date: 3.weeks.from_now, complete_date: Time.now }
)


# staff
(1..5).each do |i|
  StaffRole.seed(:id, {
    title: "Роль##{i}",
    description: Faker::Lorem::paragraph(10),
  },
  )
end

# attach staff to tcps
(1..3).each do |id|
  StaffMember.seed(:id, {
    staff_role_id: id,
    user_id: id,
    staffable_id: id,
    staffable_type: 'Tcp'
  }
  )
end

