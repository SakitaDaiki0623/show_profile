class CreateRankingBlockLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :ranking_block_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ranking_block, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :ranking_block_id], unique: true
    end
  end
end
