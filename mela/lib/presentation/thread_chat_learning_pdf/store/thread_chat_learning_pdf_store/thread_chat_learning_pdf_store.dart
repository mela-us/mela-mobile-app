import 'dart:io';

import 'package:mela/constants/enum.dart';
import 'package:mela/domain/entity/divided_lecture/divided_lecture.dart';
import 'package:mela/domain/entity/image_origin/image_origin.dart';
import 'package:mela/domain/entity/message_chat/conversation.dart';
import 'package:mela/domain/entity/message_chat/normal_message.dart';
import 'package:mela/domain/entity/question/question.dart';
import 'package:mela/domain/usecase/chat/get_token_chat_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_exercise_usecase.dart';
import 'package:mela/domain/usecase/chat_with_exercise/send_message_chat_pdf_usecase.dart';
import 'package:mobx/mobx.dart';

part 'thread_chat_learning_pdf_store.g.dart';

class ThreadChatLearningPdfStore = _ThreadChatLearningPdfStore
    with _$ThreadChatLearningPdfStore;

abstract class _ThreadChatLearningPdfStore with Store {
  SendMessageChatPdfUsecase sendMessageChatPdfUsecase;
  GetTokenChatUsecase getTokenChatUsecase;
  _ThreadChatLearningPdfStore(
    this.getTokenChatUsecase,
    this.sendMessageChatPdfUsecase,
  );
  @observable
  int tokenChat = 0;

  int limit = 5;

  @observable
  Conversation currentConversation = Conversation(
      conversationId: "",
      messages: [],
      hasMore: false,
      levelConversation: LevelConversation.UNIDENTIFIED,
      dateConversation: DateTime.now(),
      nameConversation: "Đoạn Chat Mới");
  @observable
  DividedLecture currentPdf = DividedLecture(
    ordinalNumber: 0,
    dividedLectureName: "",
    lectureId: "",
    topicId: "",
    levelId: "",
    contentInDividedLecture: "",
    urlContentInDividedLecture: "", //Only this is important
    sectionType: "",
  );
  @observable
  int startPage = 0;

  @observable
  int endPage = 0;

  @observable
  int currentPage = 0;

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingGetConversation = false;

  @observable
  bool isLoadingGetOlderMessages = false;

  @computed
  String get conversationName => getConversationName();

  @action
  void setIsLoading(bool value) {
    //Loading send
    isLoading = value;
  }

  @action
  void setIsLoadingConversation(bool value) {
    isLoadingGetConversation = value;
  }

  @action
  void setPDF(
      DividedLecture question, int startPage, int endPage, int currentPage) {
    this.currentPdf = DividedLecture(
      ordinalNumber: question.ordinalNumber,
      dividedLectureName: question.dividedLectureName,
      lectureId: question.lectureId,
      topicId: question.topicId,
      levelId: question.levelId,
      contentInDividedLecture: question.contentInDividedLecture,
      urlContentInDividedLecture: question.urlContentInDividedLecture,
      sectionType: question.sectionType,
    );
    this.startPage = startPage;
    this.endPage = endPage;
    this.currentPage = currentPage;
  }

  String getConversationName() {
    return currentConversation.nameConversation.isEmpty
        ? "Đoạn Chat Mới"
        : currentConversation.nameConversation;
  }

  @action
  Future<void> sendChatMessage(
    String message,
    List<File> images,
  ) async {
    try {
      List<ImageOrigin> imageSources = [];
      for (var item in images) {
        imageSources.add(ImageOrigin(image: item, isImageUrl: false));
      }
      currentConversation.messages.add(NormalMessage(
          text: message, isAI: false, imageSourceList: imageSources));
      currentConversation.messages.add(NormalMessage(text: null, isAI: true));
      //Copy with to trigger thread chat screen to update
      currentConversation = currentConversation.copyWith();
      // print("Sa +++++++++Current conversation: ${currentPage}");
      setIsLoading(true);
      Conversation responseMessage = await sendMessageChatPdfUsecase.call(
          params: ChatPdfRequestParams(
        message: message,
        images: images,
        pdfUrl: currentPdf.urlContentInDividedLecture,
        startPage: startPage,
        endPage: endPage,
        currentPage: currentPage,
      ));
      currentConversation.messages.last = responseMessage.messages.last;
      currentConversation.nameConversation = responseMessage.nameConversation;
      currentConversation.levelConversation = responseMessage.levelConversation;
      currentConversation = currentConversation.copyWith();
      await getTokenChat();
    } catch (e) {
      print("Error: $e");
      currentConversation.messages.last = NormalMessage(
          text: "Có lỗi xảy ra. Bạn thử lại sau giúp Mela nhé!", isAI: true);
      currentConversation = currentConversation.copyWith();
    } finally {
      setIsLoading(false);
    }
  }

  @action
  void clearConversation() {
    limit = 5;
    currentConversation = Conversation(
        conversationId: "",
        messages: [],
        hasMore: false,
        levelConversation: LevelConversation.UNIDENTIFIED,
        dateConversation: DateTime.now(),
        nameConversation: "");
  }

  @action
  Future<void> getTokenChat() async {
    try {
      int token = await getTokenChatUsecase.call();
      tokenChat = token;
    } catch (e) {
      print("Error when get token chat: $e");
      tokenChat = 0;
    }
  }

  void resetLimit() {
    limit = 5;
  }
}
  // constructor:--------------------------------