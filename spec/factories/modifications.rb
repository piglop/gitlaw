# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :modification do
    user nil
    original nil
    title "MyString"
    motivations "MyText"
    text "MyText"
  end
end
