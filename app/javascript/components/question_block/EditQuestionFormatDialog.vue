<!-- app/javascript/components/TextFormatDialog.vue -->
<template>
  <div>
    <v-dialog
      :value="isShownEditQuestionFormatDialog"
      max-width="800"
      persistent
      @input="$emit('input', $event.target.isShownEditQuestionFormatDialog)"
    >
      <v-card :color="questionBlockColor">
        <v-row justify="end" class="mr-2 mt-2">
          <v-btn
            :color="questionBlockColor"
            @click="hundleCloseQuestionBlockEditDialog"
          >
            ✖︎
          </v-btn>
        </v-row>
        <p
          class="font-weight-bold text-white text-4xl text-center mt-10 mb-10"
        >
          クエスチョンブロックを編集
        </p>

        <div class="p-10 bg-question-prof-block bg-fixed">
          <v-row align="center" v-show="!isShownForm">
            <v-col cols="12" md="10">
              <p class="text-2xl font-bold text-gray-600 pt-3">
                {{ editQuestionBlock.title }}
              </p>
            </v-col>
            <v-col cols="12" md="1">
              <v-btn
                :id="'edit-question-block-title-button-' + editQuestionBlock.id"
                tile
                small
                color="red lighten-4"
                @click="showEditQuestionBlockTitleForm"
              >
                <v-icon> mdi-pencil </v-icon>
              </v-btn>
            </v-col>
          </v-row>

          <!-- タイトル編集フォーム -->
          <div v-show="isShownForm">
            <ValidationObserver ref="observer" v-slot="{ invalid }">
              <form>
                <div>
                  <label class="form-label-question-block" for="question_block_title"
                    >タイトル</label
                  >
                  <ValidationProvider
                    v-slot="{ errors }"
                    name="タイトル"
                    rules="input_required|max:50"
                  >
                    <input
                      :id="'edit-question-title-form-' + editQuestionBlockForForm.id"
                      :value="editQuestionBlockForForm.title"
                      @input="
                        editQuestionBlockForForm.title = $event.target.value
                      "
                      class="input-form-question-block"
                      name="question_block[question_block_title]"
                      type="text"
                    />
                    <span class="text-red-400">{{ errors[0] }}</span>
                  </ValidationProvider>
                </div>
                <v-row justify="end" align="center" class="pt-3">
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'update-question-item-button-' +
                        editQuestionBlockForForm.id
                      "
                      tile
                      small
                      color="red lighten-4"
                      :disabled="invalid"
                      @click="
                        hundleEditQuestionBlockTitle(editQuestionBlockForForm)
                      "
                    >
                      更新
                    </v-btn>
                  </v-col>
                  <v-col cols="12" md="1">
                    <v-btn
                      :id="
                        'cancel-question-item-update-button-' +
                        editQuestionBlockForForm.id
                      "
                      tile
                      small
                      color="red darken-1"
                      @click="hideEditQuestionBlockTitleForm"
                    >
                      ×
                    </v-btn>
                  </v-col>
                </v-row>
              </form>
            </ValidationObserver>
          </div>

          <!-- Item Form -->
          <EditQuestionBlockItem
            questionBlockItemId="edit-question-item-1"
            :questionItem="questionItem1"
            :questionNameForValidation="questionNameForValidation1"
            :answerNameForValidation="answerNameForValidation1"
            :questionItemLength="questionItemLength"
            :isTheItemEditing="isTheFirstItemEditing"
            :question-block-color="questionBlockColor"
            @show-edit-question-item-form="showTheFirstEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheFirstEditQuestionItemForm"
          />
          <EditQuestionBlockItem
            questionBlockItemId="edit-question-item-2"
            :questionItem="questionItem2"
            :questionNameForValidation="questionNameForValidation2"
            :answerNameForValidation="answerNameForValidation2"
            :isTheItemEditing="isTheSecondItemEditing"
            :questionItemLength="questionItemLength"
            :question-block-color="questionBlockColor"
            v-if="questionItemLength >= 2"
            @show-edit-question-item-form="showTheSecondEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheSecondEditQuestionItemForm"
          />
          <EditQuestionBlockItem
            questionBlockItemId="edit-question-item-3"
            :questionItem="questionItem3"
            :questionNameForValidation="questionNameForValidation3"
            :answerNameForValidation="answerNameForValidation3"
            :isTheItemEditing="isTheThirdItemEditing"
            :questionItemLength="questionItemLength"
            :question-block-color="questionBlockColor"
            v-if="questionItemLength >= 3"
            @show-edit-question-item-form="showTheThirdEditQuestionItemForm"
            @hide-edit-question-item-form="hideTheThirdEditQuestionItemForm"
          />

          <IndividualCreateQuestionBlockItem
            :parentQuestionBlockId="parentQuestionBlockId"
            v-if="questionItemLength < 3"
            ref="IndividualCreateQuestionBlockItem"
          />

          <div
            class="mt-3 font-weight-bold text-gray-600 text-sm"
          >
            {{ certainlyPushUpdateButton }}
          </div>
          <div class="text-center mt-3">
            <v-btn
              id="creation_button"
              type="submit"
              depressed
              elevation="4"
              x-large
              :color="questionBlockColor"
              class="white--text"
              @click="hundleCloseQuestionBlockEditDialog"
            >
              編集をおしまいにする
            </v-btn>
          </div>
        </div>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
// plugins
import axios from "axios";
import { mapState, mapActions } from "vuex";

// components ----------
import EditQuestionBlockItem from "../question_block/EditQuestionBlockItem";
import IndividualCreateQuestionBlockItem from "../question_block/IndividualCreateQuestionBlockItem";

export default {
  components: {
    EditQuestionBlockItem,
    IndividualCreateQuestionBlockItem,
  },
  props: {
    isShownEditQuestionFormatDialog: {
      type: Boolean,
      required: true,
    },
    editQuestionBlock: {
      type: Object,
      required: true,
    },
    questionBlockColor: {
      type: String,
      required: false,
    },
  },
  data() {
    return {
      questionNameForValidation1: "1番目の質問",
      answerNameForValidation1: "1番目の答え",
      questionNameForValidation2: "2番目の質問",
      answerNameForValidation2: "2番目の答え",
      questionNameForValidation3: "3番目の質問",
      answerNameForValidation3: "3番目の答え",
      certainlyPushUpdateButton: "※変更する時は必ず「更新」ボタンを押してね！",

      isShownForm: false,
      isTheFirstItemEditing: false,
      isTheSecondItemEditing: false,
      isTheThirdItemEditing: false,
    };
  },
  computed: {
    ...mapState("questionBlocks", ["questionBlocks"]),
    ...mapState("questionBlocks", ["questionItems"]),

    editQuestionBlockForForm() {
      return Object.assign({}, this.editQuestionBlock);
    },
    questionItemLength() {
      return this.questionItemsOfEditQuestionBlock.length;
    },
    additionalFormNum() {
      return 3 - this.questionItemLength;
    },
    questionItemsOfEditQuestionBlock() {
      return this.questionItems.filter(
        (questionItem) =>
          questionItem.question_block.id == this.editQuestionBlock.id
      );
    },
    questionItem1() {
      return (this.questionItemsOfEditQuestionBlock[0] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[0]
      ));
    },
    questionItem2() {
      if (this.questionItemsOfEditQuestionBlock[1] == undefined) return;
      return (this.questionItemsOfEditQuestionBlock[1] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[1]
      ));
    },
    questionItem3() {
      if (this.questionItemsOfEditQuestionBlock[2] == undefined) return;
      return (this.questionItemsOfEditQuestionBlock[2] = Object.assign(
        {},
        this.questionItemsOfEditQuestionBlock[2]
      ));
    },
    // 新規作成のために親であるクエスチョンアイテムブロックのidを渡すためのメソッド
    parentQuestionBlockId() {
      return this.editQuestionBlock.id;
    },
  },
  methods: {
    ...mapActions({
      patchQuestionBlock: "questionBlocks/patchQuestionBlock",
    }),
    hundleEditQuestionBlockTitle(editQuestionBlock) {
      if (editQuestionBlock.title == "") return;
      this.patchQuestionBlock(editQuestionBlock);
      this.editQuestionBlock.title = editQuestionBlock.title;
      this.hideEditQuestionBlockTitleForm();
      this.$store.dispatch("flash/setFlash", {
        type: "success",
        message: "クエスチョンブロックのタイトルを更新したよ！",
        color: this.questionBlockColor,
      });
    },

    addQuestionItemNum() {
      this.questionItemNum++;
    },
    deleteQuestionItemNum() {
      this.questionItemNum--;
    },

    closeEditQuestionFormatDialog() {
      this.$emit("close-question-block-format-dialog");
      this.hideAllEditQuestionItemForm();
    },

    // 元のアイテムの状態に戻す
    revertItemStateBeforeEdit() {
      this.$emit("close-question-block-edit-dialog", this.editQuestionBlock);
    },

    hundleCloseQuestionBlockEditDialog() {
      this.revertItemStateBeforeEdit();
      this.closeEditQuestionFormatDialog();

      if (this.questionItemLength < 3) {
        // 子コンポーネントのメソッドの呼び出し
        this.$refs.IndividualCreateQuestionBlockItem.resetQuestionItem();
      }
      requestAnimationFrame(() => {
        this.$refs.observer.reset();
      });
    },

    // FORMごとの表示・非表示の切り替え
    showEditQuestionBlockTitleForm() {
      this.isShownForm = true;
    },
    hideEditQuestionBlockTitleForm() {
      this.isShownForm = false;
    },
    showTheFirstEditQuestionItemForm() {
      this.isTheFirstItemEditing = true;
    },
    hideTheFirstEditQuestionItemForm() {
      this.isTheFirstItemEditing = false;
    },
    showTheSecondEditQuestionItemForm() {
      this.isTheSecondItemEditing = true;
    },
    hideTheSecondEditQuestionItemForm() {
      this.isTheSecondItemEditing = false;
    },
    showTheThirdEditQuestionItemForm() {
      this.isTheThirdItemEditing = true;
    },
    hideTheThirdEditQuestionItemForm() {
      this.isTheThirdItemEditing = false;
    },

    // 全てのフォームの表示をオフにする
    hideAllEditQuestionItemForm() {
      this.hideEditQuestionBlockTitleForm();
      this.hideTheFirstEditQuestionItemForm();
      this.hideTheSecondEditQuestionItemForm();
      this.hideTheThirdEditQuestionItemForm();
    },
  },
};
</script>