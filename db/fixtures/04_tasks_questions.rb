# coding: utf-8

(1..3).each do |i|
  (%w(Tcp)).each do |type|
    Task.seed(:id,
       { taskable_id: i, taskable_type: type, title: "Задача##{i}", description: Faker::Lorem::paragraph(10),
         priority: :medium, is_complete: true },
       { taskable_id: i, taskable_type: type, title: "Задача##{i+3}", description: Faker::Lorem::paragraph(15),
         priority: :high, is_complete: false },
    )
    Question.seed(:id,
      { questionable_id: i, questionable_type: type, title: "Вопрос##{i}", description: Faker::Lorem::paragraph(10),
        priority: :medium, is_complete: true },
      { questionable_id: i, questionable_type: type, title: "Вопрос##{i+3}", description: Faker::Lorem::paragraph(15),
        priority: :high, is_complete: false },
    )
  end
end

Task.find_each do |task|
  task.users << User.first
end

Question.find_each do |question|
  question.users << User.first
end