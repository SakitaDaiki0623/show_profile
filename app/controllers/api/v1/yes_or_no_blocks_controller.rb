# app/controllers/api/v1/yes_or_no_blocks_controller-copy.rb
module Api
  module V1
    class YesOrNoBlocksController < ApiController
      before_action :set_yes_or_no_block, only: %i[show update destroy]

      def index
        @yes_or_no_blocks = YesOrNoBlock.by_team(current_user)
        render json: ActiveModel::Serializer::CollectionSerializer.new(
          @yes_or_no_blocks,
          serializer: YesOrNoBlockSerializer
        ).to_json
      end

      def create
        @yes_or_no_block_item_register = YesOrNoBlockItemRegister.new(set_params)
        if @yes_or_no_block_item_register.save_block_and_items
          @yes_or_no_block = YesOrNoBlock.last # TODO: リファクタリング YesOrNoBlock.last => より確実に作成されたブロックを取得
          render json: @yes_or_no_block
        else
          render json: @yes_or_no_block_item_register.errors, status: :bad_request
        end
      end

      def show; end

      def update
        if @yes_or_no_block.update!(yes_or_no_block_params)
          render json: @yes_or_no_block
        else
          render json: @yes_or_no_block.errors, status: :bad_request
        end
      end

      def destroy
        @yes_or_no_block.destroy!
        render json: @yes_or_no_block
      end

      private

      def set_params
        params.permit(
          :yes_or_no_title, :yes_or_no_item_content1,
          :yes_or_no_item_answer1, :yes_or_no_item_content2, :yes_or_no_item_answer2, :yes_or_no_item_content3,
          :yes_or_no_item_answer3, :current_user
        ).merge(profile_block_id: ProfileBlock.find_by(user_id: User.find(current_user.id)).id)
      end

      def yes_or_no_block_params
        params.require(:yes_or_no_block).permit(:title)
      end

      def set_yes_or_no_block
        @yes_or_no_block = current_user.profile_block.yes_or_no_blocks.find(params[:id])
      end
    end
  end
end