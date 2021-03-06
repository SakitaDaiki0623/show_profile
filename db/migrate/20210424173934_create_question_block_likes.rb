class CreateQuestionBlockLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :question_block_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question_block, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :question_block_id], unique: true
    end
  end
end
