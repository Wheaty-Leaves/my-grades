FactoryBot.define do
  factory :student do
    id { Faker::Number.number(digits: 7) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    id = "a" + (Faker::Number.number(digits: 7)).to_s
    uniID { id }
    email {"#{first_name}.#{last_name}@student.adelaide.edu.au".downcase}
    password {"Password1"}
    created_at { Faker::Date.backward(days: 14) }
  end

  factory :teacher do
    id { Faker::Number.number(digits: 7) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    id = "a" + (Faker::Number.number(digits: 7)).to_s
    uniID { id }
    email {"#{first_name}.#{last_name}@adelaide.edu.au".downcase}
    password {"Password1"}
    created_at { Faker::Date.backward(days: 14) }
  end

  factory :course do
    name { Faker::Name.name }
  end


end