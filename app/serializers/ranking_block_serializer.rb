class RankingBlockSerializer < ApplicationSerializer
  attributes :id, :title, :first_place, :second_place, :third_place, :owing_user_id, :owing_user_image, :owing_user_name
  belongs_to :profile_block, serializer: ProfileBlockSerializer
  lazy_has_many :ranking_block_likes
  lazy_has_many :users, through: :ranking_block_likes
end
