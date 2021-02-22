FactoryBot.define do
  factory :random_forum, class: Forum do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end

  factory :random_comment, class: Comment do
    description { Faker::Lorem.paragraph }
    association :forum, factory: :random_forum

    # this is how to handle self-reference in FactoryBot
    # Traits allow you to group attributes together and then apply them to any factory.
    # https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md#traits
    trait :with_parent_comment do
      association :parent_comment, factory: :random_comment
    end
  end
end
