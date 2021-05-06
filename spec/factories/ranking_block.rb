# == Schema Information
#
# Table name: ranking_blocks
#
#  id                 :bigint           not null, primary key
#  title              :string(255)      not null
#  first_place        :string(255)      not null
#  second_place       :string(255)      not null
#  third_place        :string(255)      not null
#  profile_block_id   :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null

# spec/factories/ranking_block.rb
FactoryBot.define do
  factory :ranking_block do
    title { Faker::Lorem.sentence }
    first_place  { Faker::Lorem.sentence }
    second_place { Faker::Lorem.sentence }
    third_place  { Faker::Lorem.sentence }
    association :profile_block
  end
end