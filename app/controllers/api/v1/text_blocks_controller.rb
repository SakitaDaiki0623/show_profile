# app/controllers/api/v1/text_blocks_controller.rb
module Api
  module V1
    class TextBlocksController < ApiController
      before_action :set_text_block, only: %i[update destroy]
      include PostMessageModule

      def index
        @text_blocks = TextBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def create
        @text_block = current_user.profile_block.text_blocks.build(text_block_params)

        if @text_block.save
          render json: @text_block, serializer: TextBlockSerializer
        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      def update
        authorize @text_block
        if @text_block.update(text_block_params)
          render json: @text_block, serializer: TextBlockSerializer
        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      def destroy
        authorize @text_block, :update?
        @text_block.destroy!
        render json: @text_block, serializer: TextBlockSerializer
      end

      def popular_blocks
        @text_popular_blocks = TextBlock.by_team(current_user).popular_blocks
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_popular_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def random_current_user_likes_blocks
        @text_blocks = []
        @random_current_user_likes = TextBlockLike.filter_by_current_user(current_user.id)
        @random_current_user_likes.each do |like|
          @text_blocks << TextBlock.find(like.text_block_id)
        end
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @text_blocks,
          serializer: TextBlockSerializer
        ).to_json
      end

      def post_to_slack_after_create
        @text_block = current_user.profile_block.text_blocks.build(text_block_params)
        if @text_block.valid?
          post_text_block(@text_block)
          render json: @text_block, status: :no_content

        else
          render json: @text_block.errors, status: :bad_request
        end
      end

      private

      def text_block_params
        params.require(:text_block).permit(:title, :text)
      end

      def set_text_block
        @text_block = TextBlock.find(params[:id])
      end
    end
  end
end
